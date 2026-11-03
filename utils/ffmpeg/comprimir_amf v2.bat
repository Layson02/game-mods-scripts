@echo off
setlocal enabledelayedexpansion

if not exist "Compactados" mkdir "Compactados"

set /a total=0
set /a sucesso=0

for %%i in (*.mp4) do (
    set /a total+=1
    echo.
    echo [!total!] Processando: "%%~nxi"
    ffmpeg -n -i "%%i" -c:v hevc_amf -b:v 4M -maxrate 6M -c:a copy "Compactados\%%~nxi"
    
    if !errorlevel! equ 0 (
        set /a sucesso+=1
        set "arquivo_!sucesso!=%%~nxi"
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