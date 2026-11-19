@echo off
setlocal enabledelayedexpansion

if not exist "Compactados" mkdir "Compactados"

set /a total=0
set /a sucesso=0

for %%i in (*.mp4 *.mov *.avi *.wmv *.webm) do (
    set /a total+=1
    echo.
    echo [!total!] Processando: "%%~nxi"
    ffmpeg -n -i "%%i" -c:v hevc_amf -rc cqp -qp_i 24 -qp_p 26 -quality quality -pix_fmt yuv420p -tag:v hvc1 -movflags +faststart -c:a aac -b:a 192k "Compactados\%%~ni.mp4"

    if !errorlevel! equ 0 (
        set /a sucesso+=1
        set "arquivo_!sucesso!=%%~nxi"
    ) else (
        echo [AVISO] Falha ao processar: "%%~nxi"
    )
)

echo.
echo ===================== RESUMO =====================
echo Total processado com sucesso: !sucesso! de !total!
echo.
if !sucesso! gtr 0 (
    echo Arquivos concluidos:
    for /l %%k in (1,1,!sucesso!) do (
        echo  - !arquivo_%%k!
    )
)
echo =================================================
pause