#!/bin/bash

# 在线钢琴 - 快速启动脚本
# Piano Online - Quick Start Script

echo "🎹 在线钢琴 Piano Online 🎹"
echo "=============================="
echo ""

# 检测可用的服务器
if command -v python3 &> /dev/null; then
    echo "✅ 使用 Python 启动服务器..."
    echo "📍 访问地址: http://localhost:8080"
    echo "🛑 按 Ctrl+C 停止服务器"
    echo ""
    python3 -m http.server 8080
elif command -v python &> /dev/null; then
    echo "✅ 使用 Python 启动服务器..."
    echo "📍 访问地址: http://localhost:8080"
    echo "🛑 按 Ctrl+C 停止服务器"
    echo ""
    python -m SimpleHTTPServer 8080
elif command -v npx &> /dev/null; then
    echo "✅ 使用 Node.js 启动服务器..."
    echo "📍 访问地址: http://localhost:8080"
    echo "🛑 按 Ctrl+C 停止服务器"
    echo ""
    npx serve -p 8080 .
else
    echo "❌ 错误: 未找到 Python 或 Node.js"
    echo ""
    echo "请安装以下任一工具:"
    echo "  - Python 3: https://www.python.org/"
    echo "  - Node.js: https://nodejs.org/"
    echo ""
    echo "或者直接用浏览器打开 index.html 文件"
    exit 1
fi
