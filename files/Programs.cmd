@echo off
color 03
Mode 128,29
C:
cd "C:\Users\%username%\Documents\SULFURAX\SCZOptimizer"

curl -g -L -# -o "C:\Users\%username%\Documents\SULFURAX\SCZOptimizer\Ninite.exe" "https://raw.githubusercontent.com/SULFURA/SCZOptimizer/main/files/Ninite.exe"
start Ninite.exe
curl -g -L -# -o "C:\Users\%username%\Documents\SULFURAX\SCZOptimizer\Lightshot.exe" "https://app.prntscr.com/build/setup-lightshot.exe"
start Lightshot.exe
curl -g -L -# -o "C:\Users\%username%\Documents\SULFURAX\SCZOptimizer\Java.exe" "https://javadl.oracle.com/webapps/download/AutoDL?BundleId=247133_10e8cce67c7843478f41411b7003171c"
start Java.exe
curl -g -L -# -o "C:\Users\%username%\Documents\SULFURAX\SCZOptimizer\DirectX.exe" "https://www.microsoft.com/fr-fr/download/confirmation.aspx?id=35"
start DirectX.exe
curl -g -L -# -o "C:\Users\%username%\Documents\SULFURAX\SCZOptimizer\Visual.zip" "https://raw.githubusercontent.com/SULFURA/SCZOptimizer/main/files/Visual.zip"
powershell -NoProfile Expand-Archive 'C:\Users\%username%\Documents\SULFURAX\SCZOptimizer\Visual.zip' -DestinationPath 'C:\Users\%username%\Documents\SULFURAX\SCZOptimizer\Visual\'
del /F /Q "C:\Users\%username%\Documents\SULFURAX\SCZOptimizer\Visual.zip"
cd "C:\Users\%username%\Documents\SULFURAX\SCZOptimizer\Visual"
NSudo.exe -U:T -P:E "C:\Users\%username%\Documents\SULFURAX\SCZOptimizer\Visual\install_all.bat"

:: Clear CMD
timeout /t 5 /nobreak
cls
exit