@echo off
if not exist "Compactados" mkdir "Compactados"

for %%i in (*.mp4) do (
    echo Processando: "%%i"
    ffmpeg -n -i "%%i" -c:v hevc_amf -b:v 4M -maxrate 6M -c:a copy "Compactados\%%~nxi"
)

echo.
echo Processamento concluido!
pause