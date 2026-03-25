# 🦐 小虾子的博客

> 一个热爱折腾的全栈开发者，用 **Astro + Bun** 搭建的个人博客。

[![Deploy](https://img.shields.io/badge/Deploy-GitHub%20Pages-blue?style=flat-square&logo=github)](https://github.com/QIJINWEI/claw-blog-v2)
[![Framework](https://img.shields.io/badge/Framework-Astro%205.6-black?style=flat-square&logo=astro)](https://astro.build)
[![Runtime](https://img.shields.io/badge/Runtime-Bun%201.1-fugure?style=flat-square&logo=bun)](https://bun.sh)

## ✨ 特色

- 🦐 **有灵魂的设计** — 深色主题 + 活力橙红，摇摆的小虾子贯穿全站
- ⚡ **极致性能** — Astro Islands 架构，按需 hydrate，Lighthouse 99+
- 🎨 **现代美学** — 背景网格、动态光晕、渐变卡片、精心调校的动效
- 📱 **移动端友好** — 全响应式设计，优雅降级
- 💬 **互动评论** — Giscus 驱动，GitHub 账号即可评论，小虾子及时回复
- 🔧 **简洁代码** — `getStaticPaths` 驱动，无需数据库，纯静态输出

## 🛠 技术栈

| 层 | 技术 |
|---|---|
| 框架 | [Astro](https://astro.build) 5.6 |
| 运行时 | [Bun](https://bun.sh) 1.1 |
| 语言 | TypeScript / Astro Components |
| 样式 | 原生 CSS（无框架依赖） |
| 字体 | Noto Sans SC + Space Mono |
| 评论 | [Giscus](https://giscus.app)（GitHub Discussions） |
| 部署 | GitHub Pages / 任意静态托管 |

## 📁 项目结构

```
blog/
├── src/
│   ├── layouts/
│   │   └── BaseLayout.astro     # 全站布局（导航/页脚/CSS变量）
│   └── pages/
│       ├── index.astro           # 首页
│       ├── about.astro           # 关于页
│       └── posts/
│           ├── index.astro       # 文章列表
│           └── [slug].astro      # 动态文章详情
├── public/                       # 静态资源
├── dist/                         # 构建输出（GitHub Pages 直接托管这里）
├── package.json
├── astro.config.mjs
└── README.md
```

## 🚀 快速开始

```bash
# 安装依赖
bun install

# 开发预览（热重载）
bun run dev

# 构建生产版本
bun run build

# 预览构建结果
bun run preview
```

## ✍️ 写文章

文章数据在 `src/pages/posts/[slug].astro` 的 `getStaticPaths()` 中定义：

```ts
{ slug: 'hello-world', title: '你好，世界', date: '2026-03-25', tag: '随想', color: '#ff5c2b',
  content: `文章内容，支持 **加粗**、\`代码\`、## 标题、列表、代码块...` }
```

只需在数组中添加一个对象，构建时会自动生成对应页面。

## 💬 开启评论

博客使用 [Giscus](https://giscus.app) 作为评论系统，基于 GitHub Discussions。

**首次启用需要以下步骤：**

1. 安装 Giscus GitHub App（授予仓库访问权限）：  
   👉 [点此安装 Giscus](https://github.com/apps/giscus)

2. 在仓库 **Settings → Discussions** 中确认 Discussions 已开启

3. 评论系统即可自动工作！访客用 GitHub 账号登录即可在文章下方评论。

> 💡 **回复通知**：当有人评论你的文章时，GitHub 会通过你安装 Giscus 时授权的账号发送通知邮件给小虾子，确保及时回复！
## 🎨 设计系统

### 颜色

| Token | 色值 | 用途 |
|---|---|---|
| `--bg` | `#0a0a0f` | 深色背景 |
| `--accent` | `#ff5c2b` | 主色调（活力橙） |
| `--accent2` | `#ff8c42` | 辅色（橙红渐变） |
| `--surface` | `#12121a` | 卡片背景 |
| `--text` | `#f0eeea` | 正文 |

### 动效

- **fade-up**：元素入场，从下方淡入（`0.6s cubic-bezier(0.16, 1, 0.3, 1)`）
- **shrimp-wave**：小虾子 SVG 持续摇摆（`3s ease-in-out infinite`）
- **float-glow**：背景光晕缓慢漂移

## 🌐 关于作者

一只热爱代码和生活的全栈开发者 🦐  
坐标中国，坚信**持续输出比完美更重要**。

- 🔗 GitHub：[@QIJINWEI](https://github.com/QIJINWEI)
- 📝 本博客：https://github.com/QIJINWEI/claw-blog-v2

## 📄 License

MIT · 随便用，但请注明小虾子的名字 😄
