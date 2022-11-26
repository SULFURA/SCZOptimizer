@echo off
color 03
Mode 128,29
C:
cd "C:\SULFURAX\SCZOptimizer"

curl -g -L -# -o "C:\SULFURAX\SCZOptimizer\Ninite.exe" "https://raw.githubusercontent.com/SULFURA/SCZOptimizer/main/files/Ninite.exe"
start Ninite.exe
pause
curl -g -L -# -o "C:\SULFURAX\SCZOptimizer\Lightshot.exe" "https://app.prntscr.com/build/setup-lightshot.exe"
start Lightshot.exe
pause
curl -g -L -# -o "C:\SULFURAX\SCZOptimizer\Java.exe" "https://javadl.oracle.com/webapps/download/AutoDL?BundleId=247133_10e8cce67c7843478f41411b7003171c"
start Java.exe
pause
curl -g -L -# -o "C:\SULFURAX\SCZOptimizer\DirectX.exe" "https://raw.githubusercontent.com/SULFURA/SCZOptimizer/main/files/DirectX.exe"
start DirectX.exe
pause
curl -g -L -# -o "C:\SULFURAX\SCZOptimizer\Visual.zip" "https://raw.githubusercontent.com/SULFURA/SCZOptimizer/main/files/Visual.zip"
powershell -NoProfile Expand-Archive 'C:\SULFURAX\SCZOptimizer\Visual.zip' -DestinationPath 'C:\SULFURAX\SCZOptimizer\Visual\'
del /F /Q "C:\SULFURAX\SCZOptimizer\Visual.zip"
cd "C:\SULFURAX\SCZOptimizer\Visual"
start install_all.bat

:: Clear CMD
timeout /t 5 /nobreak
cls
exit