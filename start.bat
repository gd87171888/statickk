@echo off
chcp 65001 >nul
title 在线钢琴 Piano Online

echo.
echo 🎹 在线钢琴 Piano Online 🎹
echo ==============================
echo.

REM 检测Python
where python >nul 2>nul
if %errorlevel% equ 0 (
    echo ✅ 使用 Python 启动服务器...
    echo 📍 访问地址: http://localhost:8080
    echo 🛑 按 Ctrl+C 停止服务器
    echo.
    python -m http.server 8080
    goto :end
)

REM 检测Node.js
where node >nul 2>nul
if %errorlevel% equ 0 (
    echo ✅ 使用 Node.js 启动服务器...
    echo 📍 访问地址: http://localhost:8080
    echo 🛑 按 Ctrl+C 停止服务器
    echo.
    npx serve -p 8080 .
    goto :end
)

REM 都没找到
echo ❌ 错误: 未找到 Python 或 Node.js
echo.
echo 请安装以下任一工具:
echo   - Python 3: https://www.python.org/
echo   - Node.js: https://nodejs.org/
echo.
echo 或者直接用浏览器打开 index.html 文件
echo.
pause
exit /b 1

:end
pause
