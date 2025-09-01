#!/bin/bash

# Rust 中文文档中心构建脚本
# 用于构建所有集成的 Rust 中文文档

set -e  # 遇到错误时退出

echo "🚀 开始构建 Rust 中文文档中心..."

# 检查 mdBook 是否安装
if ! command -v mdbook &> /dev/null; then
    echo "❌ mdBook 未安装，请先运行: cargo install mdbook"
    exit 1
fi

echo "✅ mdBook 已安装: $(mdbook --version)"

# 构建 trpl-zh-cn
echo "📚 构建 Rust 程序设计语言中文版..."
if [ -d "trpl-zh-cn" ]; then
    cd trpl-zh-cn
    mdbook build
    echo "✅ trpl-zh-cn 构建完成"
    cd ..
else
    echo "⚠️  trpl-zh-cn 目录不存在，跳过构建"
fi

# 构建 rust-by-example-cn
echo "📚 构建通过例子学 Rust 中文版..."
if [ -d "rust-by-example-cn" ]; then
    cd rust-by-example-cn
    mdbook build
    echo "✅ rust-by-example-cn 构建完成"
    cd ..
else
    echo "⚠️  rust-by-example-cn 目录不存在，跳过构建"
fi

echo "🎉 所有文档构建完成！"
echo ""
echo "📖 你可以通过以下方式访问文档中心："
echo "   1. 打开 index.html 文件"
echo "   2. 或启动本地服务器："
echo "      python -m http.server 8080"
echo "      然后访问 http://localhost:8080"
echo ""
echo "📁 构建后的文档位置："
echo "   - trpl-zh-cn/book/"
echo "   - rust-by-example-cn/book/"
