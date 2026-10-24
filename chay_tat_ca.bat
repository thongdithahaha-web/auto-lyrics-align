@echo off
chcp 65001 >nul
setlocal
cd /d "%~dp0"

echo ===================================================
echo 🎤 Tool Lyric by lekimlamcode - Khởi Động Tất Cả
echo ===================================================
echo.

:: Giải phóng cổng 7864 nếu đang bị chiếm
for /f "tokens=5" %%a in ('netstat -aon ^| findstr :7864 ^| findstr LISTENING') do (
    echo [INFO] Đang giải phóng cổng 7864 (PID: %%a)...
    taskkill /F /PID %%a >nul 2>&1
)

echo [1/3] Đang khởi động Backend Server (FastAPI)...
start "Tool Lyric Server" cmd /c "python backend\fastapi_app.py"

echo [2/3] Chờ máy chủ sẵn sàng trong 4 giây...
timeout /t 4 /nobreak >nul

echo [3/3] Đang mở đường truyền Cloudflare Tunnel cho điện thoại...
start "Cloudflare Tunnel - Link Dien Thoai" cmd /k "cloudflared.exe tunnel --url http://127.0.0.1:7864"

:: Mở web trên máy tính
start http://127.0.0.1:7864/auto

echo.
echo ===================================================
echo ✅ ĐÃ KHỞI ĐỘNG XONG!
echo - Web trên máy tính: http://127.0.0.1:7864/auto
echo - Link cho điện thoại: Xem ở cửa sổ 'Cloudflare Tunnel' (dòng https://...trycloudflare.com)
echo ===================================================
echo.
pause

