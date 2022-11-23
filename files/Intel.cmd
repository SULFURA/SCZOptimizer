@echo off
color 03
Mode 128,29

reg add "HKLM\SOFTWARE\Intel\GMM" /v "DedicatedSegmentSize" /t REG_DWORD /d "1024" /f >nul 2>&1

:: Clear CMD
timeout /t 5 /nobreak
cls
exit