#!/bin/bash
# 使用 GitHub API 推送博客代码

GITHUB_TOKEN="${GITHUB_TOKEN}"
GITHUB_USER="QIJINWEI"
REPO="claw-blog"
API_BASE="https://api.github.com"

# 辅助函数：获取文件 SHA
get_sha() {
    local path="$1"
    curl -s -H "Authorization: Bearer $GITHUB_TOKEN" \
         "$API_BASE/repos/$GITHUB_USER/$REPO/contents/$path" | \
         python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('sha',''))" 2>/dev/null
}

# 辅助函数：推送文件
push_file() {
    local local_path="$1"
    local repo_path="$2"
    local content=$(cat "$local_path" | base64 -w0)
    local sha=$(get_sha "$repo_path")
    
    local data
    if [ -n "$sha" ]; then
        data="{\"message\":\"Update $repo_path\",\"content\":\"$content\",\"sha\":\"$sha\"}"
    else
        data="{\"message\":\"Add $repo_path\",\"content\":\"$content\"}"
    fi
    
    curl -s -X PUT \
         -H "Authorization: Bearer $GITHUB_TOKEN" \
         -H "Content-Type: application/json" \
         "$API_BASE/repos/$GITHUB_USER/$REPO/contents/$repo_path" \
         -d "$data"
}

# 推送所有文件
BLOG_DIR="/root/blog"

for file in $(find "$BLOG_DIR/dist" -type f); do
    repo_path="${file#$BLOG_DIR/}"
    echo "Pushing: $repo_path"
    push_file "$file" "$repo_path"
done

echo "✅ 推送完成！"
