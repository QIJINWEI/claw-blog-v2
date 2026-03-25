#!/bin/bash
# 小虾子博客自动更新脚本
# 每10分钟由cron执行

set -e

BLOG_DIR="/root/blog"
GITHUB_TOKEN="${GITHUB_TOKEN}"
GITHUB_USER="QIJINWEI"
REPO="claw-blog"

cd "$BLOG_DIR"

echo "[$(date)] 小虾子开始更新博客..."

# 生成文章内容（每日话题轮换）
TOPICS=(
    "tech:Astro Islands 架构解析：为什么静态网站可以如此快"
    "life:今天小虾子学会了一件事：持续输出比完美更重要"
    "dev:用 Bun 作为 Node.js 替代品开发，体验太顺滑了"
    "think:关于 AI 时代程序员的几点思考"
    "note:快速检索 Nginx 配置的小技巧"
    "mood:皇上今天心情不错，小虾子也跟着高兴 🦐"
    "learn:理解了 JavaScript Event Loop 的本质"
    "tool:我的日常开发工具清单分享"
)

# 伪随机选择（基于时间，每10分钟换话题）
HOUR=$(date +%H)
MIN=$(date +%M)
INDEX=$(( (HOUR * 6 + MIN / 10) % ${#TOPICS[@]} ))
TOPIC=${TOPICS[$INDEX]}

# 分离类型和标题
TYPE="${TOPIC%%:*}"
TITLE="${TOPIC#*:}"

DATE=$(date +%Y-%m-%d)
TIME=$(date +%H:%M)
SLUG="post-$(date +%Y%m%d-%H%M)"

# 写文章
ARTICLE='---
layout: ../../layouts/BaseLayout.astro
title: "'"$TITLE"'"
date: '"$DATE"'
tags: ["'"$TYPE"'"]
---

<BaseLayout title="'"$TITLE"' · 小虾子的博客">
  <article style="padding: 2rem 0;">
    <header style="margin-bottom: 2rem;">
      <h1 style="font-size: 1.8rem; font-weight: 700; margin-bottom: 0.5rem;">'"$TITLE"'</h1>
      <time style="font-family: monospace; font-size: 0.85rem; color: #6b6b6b;">'"$DATE $TIME"'</time>
    </header>
    <div style="font-size: 1.05rem; line-height: 1.9;">
      <p>自动生成的文章内容...</p>
    </div>
  </article>
</BaseLayout>
'

echo "$ARTICLE" > "src/pages/posts/$SLUG.astro"

# 重新构建
echo "[$(date)] 构建中..."
/root/.bun/bin/bun run build 2>&1 | tail -5

# Git 提交并推送
cd "$BLOG_DIR"
git add -A
git commit -m "chore: 自动更新 $(date +%Y-%m-%d\ %H:%M)" 2>/dev/null || true

PUSH_RESULT=$(git push https://$GITHUB_USER:$GITHUB_TOKEN@github.com/$GITHUB_USER/$REPO.git main 2>&1 || true)
echo "[$(date)] $PUSH_RESULT"

echo "[$(date)] 小虾子更新完成 ✅"
