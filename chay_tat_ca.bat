@echo off
chcp 65001 >nul
setlocal
cd /d "%~dp0"

echo ===================================================
echo   _lkimlamdev - Khoi Dong Tat Ca He Thong
echo ===================================================
echo.

:: Giai phong cong 7864 neu dang bi chiem
for /f "tokens=5" %%a in ('netstat -aon ^| findstr :7864 ^| findstr LISTENING') do (
    echo [INFO] Dang giai phong cong 7864 (PID: %%a)...
    taskkill /F /PID %%a >nul 2>&1
)

echo [1/3] Dang khoi dong Backend Server (FastAPI)...
start "Backend Server - _lkimlamdev" cmd /c "python backend\fastapi_app.py"

echo [2/3] Cho may chu khoi dong model AI trong 10 giay...
timeout /t 10 /nobreak >nul

echo [3/3] Dang mo duong truyen Cloudflare Tunnel cho dien thoai...
start "Cloudflare Tunnel - Link Dien Thoai" cmd /k "cloudflared.exe tunnel --url http://127.0.0.1:7864"

:: Mo web tren may tinh
start http://127.0.0.1:7864/auto

echo.
echo ===================================================
echo   DA KHOI DONG THANH CONG!
echo - Web tren may tinh: http://127.0.0.1:7864/auto
echo - Link cho dien thoai: Xem o cua so 'Cloudflare Tunnel' (link https://...trycloudflare.com)
echo ===================================================
echo.
pause
