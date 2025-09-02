# Rust 中文文档中心

一个集成了多个 Rust 中文文档的学习资源中心，采用 VuePress 风格的卡片式设计，为 Rust 学习者提供一站式的文档访问体验。

## 🚀 特性

- **卡片式设计**: 每个文档都以精美的卡片形式展示
- **响应式布局**: 支持桌面端和移动端访问
- **一键访问**: 点击卡片即可直接进入对应文档
- **Git 子模块管理**: 自动同步最新的文档内容
- **mdBook 构建**: 基于 mdBook 的静态站点生成

## 📚 已集成的文档

### 1. Rust 程序设计语言 (trpl-zh-cn)
- **描述**: Rust 官方教程的中文版本
- **版本**: 2021 Edition
- **状态**: 官方翻译
- **GitHub**: [KaiserY/trpl-zh-cn](https://github.com/KaiserY/trpl-zh-cn)
- **访问路径**: `./trpl-zh-cn/book/`

### 2. 通过例子学 Rust (rust-by-example-cn)
- **描述**: 通过大量可运行的代码示例学习 Rust
- **版本**: 2021 Edition
- **状态**: 官方翻译
- **GitHub**: [rust-lang-cn/rust-by-example-cn](https://github.com/rust-lang-cn/rust-by-example-cn)
- **访问路径**: `./rust-by-example-cn/book/`

### 3. Rust 语言圣经 (rust-course)
- **描述**: 最全面的 Rust 中文教程，从入门到精通
- **版本**: 最新版
- **状态**: 中文原创
- **GitHub**: [sunface/rust-course](https://github.com/sunface/rust-course)
- **访问路径**: `./rust-course/book/`

## 🛠️ 安装和使用

### 前置要求

1. **Git**: 用于管理子模块
2. **mdBook**: 用于构建文档
   ```bash
   cargo install mdbook
   ```

### 快速开始

1. **克隆项目**
   ```bash
   git clone <your-repo-url>
   cd my-docs-hub
   ```

2. **初始化子模块**
   ```bash
   git submodule init
   git submodule update
   ```

3. **构建文档**
   ```bash
   # 使用提供的构建脚本（推荐）
   # Windows
   build.bat
   
   # 或者使用交互式构建脚本
   build-and-serve.bat
   
   # 手动构建所有文档
   cd trpl-zh-cn && mdbook build && cd ..
   cd rust-by-example-cn && mdbook build && cd ..
   ```

4. **启动本地服务器**
   ```bash
   # 使用构建脚本自动启动（推荐）
   # 脚本会自动选择启动方式
   
   # 手动启动服务器
   python -m http.server 8080
   
   # 或使用 Node.js 的 serve
   npx serve .
   
   # 或使用 PHP 内置服务器
   php -S localhost:8080
   ```

5. **访问文档中心**
   打开浏览器访问 `http://localhost:8080`

## 📁 项目结构

```
my-docs-hub/
├── index.html              # 文档中心首页
├── README.md               # 项目说明
├── .gitmodules             # Git 子模块配置
├── .gitignore              # Git 忽略文件配置
├── build.bat               # Windows 构建脚本（自动启动浏览器）
├── build-and-serve.bat     # Windows 交互式构建脚本
├── trpl-zh-cn/             # Rust 程序设计语言中文版
│   ├── book/               # 构建后的 HTML 文件（不提交到 Git）
│   ├── src/                # 源文档文件
│   └── book.toml           # mdBook 配置
├── rust-by-example-cn/     # 通过例子学 Rust 中文版
│   ├── book/               # 构建后的 HTML 文件（不提交到 Git）
│   ├── src/                # 源文档文件
│   └── book.toml           # mdBook 配置
└── rust-course/            # Rust 语言圣经
    ├── book/               # 构建后的 HTML 文件（不提交到 Git）
    ├── src/                # 源文档文件
    └── book.toml           # mdBook 配置
```

> **注意**: `book/` 目录包含构建生成的 HTML 文件，这些文件不会被提交到 Git 仓库中。每次需要查看文档时，请先运行构建脚本。

## 🔄 更新文档

### 更新单个文档
```bash
# 更新 trpl-zh-cn
cd trpl-zh-cn
git pull origin main
mdbook build
cd ..

# 更新 rust-by-example-cn
cd rust-by-example-cn
git pull origin master
mdbook build
cd ..

# 更新 rust-course
cd rust-course
git pull origin main
mdbook build
cd ..
```

### 更新所有文档
```bash
# 更新所有子模块
git submodule update --remote

# 重新构建所有文档
cd trpl-zh-cn && mdbook build && cd ..
cd rust-by-example-cn && mdbook build && cd ..
cd rust-course && mdbook build && cd ..
```

## 🎨 自定义样式

文档中心使用纯 HTML/CSS/JavaScript 构建，你可以通过修改 `index.html` 文件来自定义：

- **颜色主题**: 修改 CSS 变量
- **布局**: 调整 Grid 布局
- **动画效果**: 修改 CSS 动画
- **交互逻辑**: 编辑 JavaScript 代码

## 📝 添加新文档

1. **添加子模块**
   ```bash
   git submodule add <repository-url> <folder-name>
   ```

2. **构建文档**
   ```bash
   cd <folder-name>
   mdbook build
   cd ..
   ```

3. **更新首页**
   在 `index.html` 中添加新的文档卡片

4. **提交更改**
   ```bash
   git add .
   git commit -m "Add new document: <document-name>"
   ```

## 🤝 贡献

欢迎提交 Issue 和 Pull Request 来改进这个文档中心！

### 贡献指南

1. Fork 这个项目
2. 创建你的特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交你的更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 打开一个 Pull Request

## 📄 许可证

本项目采用 MIT 许可证 - 查看 [LICENSE](LICENSE) 文件了解详情。

## 🙏 致谢

- [Rust 中文社区](https://github.com/rust-lang-cn) - 提供优秀的中文翻译
- [mdBook](https://github.com/rust-lang/mdBook) - 强大的文档生成工具
- [VuePress](https://vuepress.vuejs.org/) - 设计灵感来源

## 📞 联系方式

如果你有任何问题或建议，请通过以下方式联系：

- 提交 [Issue](https://github.com/your-username/my-docs-hub/issues)
- 发送邮件到: your-email@example.com

---

**Happy Rust Learning! 🦀**
