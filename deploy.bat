@echo off
REM 设置代码页为 UTF-8，以正确显示中文和 emoji
chcp 65001 >nul

echo 🚀 开始部署 Rust 中文文档中心...
echo.

REM --- 检查依赖环境 ---
REM 检查 mdBook
mdbook --version >nul 2>&1
if errorlevel 1 (
    echo ❌ 错误: mdBook 未安装或不在系统路径中。
    echo    请先运行 "cargo install mdbook" 进行安装。
    pause
    exit /b 1
)

REM --- 构建所有文档 ---
echo 📚 构建所有文档...
call :build_book "trpl-zh-cn" "Rust 程序设计语言"
call :build_book "rust-by-example-cn" "通过例子学 Rust"
call :build_book "rust-course" "Rust 语言圣经"

echo.
echo 🎉 所有文档构建完成！
echo.

REM --- 创建部署目录 ---
if exist "dist" (
    echo 🗑️  清理旧的部署文件...
    rmdir /s /q "dist"
)

echo 📁 创建部署目录...
mkdir "dist"

REM --- 复制文件到部署目录 ---
echo 📋 复制文件到部署目录...

REM 复制首页
copy "index.html" "dist\"

REM 复制各个文档的构建结果
if exist "trpl-zh-cn\book" (
    echo 📖 复制 Rust 程序设计语言文档...
    xcopy "trpl-zh-cn\book\*" "dist\trpl-zh-cn\" /e /i /y
)

if exist "rust-by-example-cn\book" (
    echo 📖 复制通过例子学 Rust 文档...
    xcopy "rust-by-example-cn\book\*" "dist\rust-by-example-cn\" /e /i /y
)

if exist "rust-course\book" (
    echo 📖 复制 Rust 语言圣经文档...
    xcopy "rust-course\book\*" "dist\rust-course\" /e /i /y
)

echo.
echo ✅ 部署文件准备完成！
echo 📍 部署目录: %CD%\dist
echo.
echo 💡 部署说明:
echo    - 将 dist 目录的内容上传到你的 Web 服务器
echo    - 或者推送到 GitHub Pages 的 gh-pages 分支
echo    - 或者部署到 Netlify、Vercel 等平台
echo.

pause
goto :eof

REM --- 构建子程序 ---
:build_book
set "BOOK_DIR=%~1"
set "BOOK_NAME=%~2"

echo ----------------------------------------------------
echo 🏗️  构建: %BOOK_NAME% (%BOOK_DIR%)

if not exist "%BOOK_DIR%" (
    echo 🟡 跳过: 目录 "%BOOK_DIR%" 不存在。
    goto :eof
)

pushd "%BOOK_DIR%"
mdbook build
if errorlevel 1 (
    echo ❌ 错误: "%BOOK_NAME%" 构建失败！
    popd
    pause
    exit /b 1
)
echo ✅ 完成: "%BOOK_NAME%" 构建成功。
popd
goto :eof


