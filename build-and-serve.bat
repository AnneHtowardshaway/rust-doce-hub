@echo off
REM 设置代码页为 UTF-8，以正确显示中文和 emoji
chcp 65001 >nul

echo 🚀 开始构建 Rust 中文文档中心...
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

REM 检查 Python (用于启动服务器)
python --version >nul 2>&1
if errorlevel 1 (
    echo ⚠️  警告: 未找到 Python。你将无法启动本地服务器。
    echo    但这不影响文档的构建，你仍然可以手动打开 index.html 文件。
    echo.
)

REM --- 主构建流程 ---
REM 使用 call 命令调用下面的 :build_book 子程序来构建每个文档
call :build_book "trpl-zh-cn" "Rust 程序设计语言"
call :build_book "rust-by-example-cn" "通过例子学 Rust"
REM 如果有更多文档，在这里继续添加 call 命令即可
REM call :build_book "new-book-folder" "新书的名字"

echo.
echo 🎉 所有文档已成功构建！
echo.

REM --- 选择启动方式 ---
echo 🌐 请选择启动方式：
echo.
echo    1. [推荐] 启动本地服务器 (更好的体验)
echo    2. [简单] 直接打开浏览器
echo    3. [退出] 不启动任何服务
echo.
set /p choice="请输入选择 (1/2/3): "

if "%choice%"=="1" (
    call :start_server
) else if "%choice%"=="2" (
    call :open_browser
) else if "%choice%"=="3" (
    echo.
    echo 👋 构建完成！你可以稍后手动打开 index.html 文件。
    echo.
    pause
) else (
    echo.
    echo ❌ 无效选择，默认启动本地服务器...
    call :start_server
)

goto :eof

REM --- 启动本地服务器 ---
:start_server
echo.
echo 🌐 正在启动本地服务器...
echo.

REM 检查 Python 是否可用
python --version >nul 2>&1
if errorlevel 1 (
    echo ❌ 错误: 未找到 Python，无法启动本地服务器。
    echo    正在切换到直接打开浏览器模式...
    call :open_browser
    goto :eof
)

echo ✅ 服务器启动中...
echo 📍 访问地址: http://localhost:8000
echo 🛑 按 Ctrl+C 停止服务器
echo.

REM 启动 Python HTTP 服务器
python -m http.server 8000
goto :eof

REM --- 直接打开浏览器 ---
:open_browser
echo.
echo 🌐 正在启动浏览器...
echo.

REM 检查 index.html 是否存在
if exist "index.html" (
    echo ✅ 找到 index.html，正在启动浏览器...
    
    REM 尝试使用默认浏览器打开
    start "" "index.html"
    
    echo.
    echo 🎯 浏览器已启动！如果页面没有自动打开，请手动访问：
    echo    📍 文件路径: %CD%\index.html
    echo.
) else (
    echo ❌ 错误: 未找到 index.html 文件！
    echo    请检查构建过程是否成功完成。
    echo.
    pause
    exit /b 1
)

echo ✅ 文档中心已准备就绪！
echo.
pause
goto :eof

REM --- 构建子程序 (相当于一个函数) ---
:build_book
REM %1 是第一个参数 (目录名), %2 是第二个参数 (文档名)
set "BOOK_DIR=%~1"
set "BOOK_NAME=%~2"

echo ----------------------------------------------------
echo 🏗️  开始构建: %BOOK_NAME% (%BOOK_DIR%)

if not exist "%BOOK_DIR%" (
    echo 🟡 跳过: 目录 "%BOOK_DIR%" 不存在。
    goto :eof
)

REM pushd 会切换目录并记住当前位置
pushd "%BOOK_DIR%"

mdbook build
if errorlevel 1 (
    echo ❌ 错误: "%BOOK_NAME%" 构建失败！请检查该目录下的 mdBook 配置。
    popd
    pause
    exit /b 1
)

echo ✅ 完成: "%BOOK_NAME%" 构建成功。
REM popd 会安全地返回到 pushd 之前的位置
popd
goto :eof
