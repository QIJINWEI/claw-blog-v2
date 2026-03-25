#!/bin/bash
# 使用 GitHub API 推送博客（绕过网络限制）
# 通过 api.github.com 上传文件

GITHUB_TOKEN="${GITHUB_TOKEN}"
GITHUB_USER="QIJINWEI"
REPO="claw-blog"
API="https://api.github.com"

cd /root/blog

echo "📤 开始通过 GitHub API 推送代码..."

# 推送单个文件
push_file() {
    local src="$1"
    local dest="$2"
    
    # 获取文件SHA（如果已存在）
    sha=$(curl -s -H "Authorization: Bearer $GITHUB_TOKEN" \
        "$API/repos/$GITHUB_USER/$REPO/contents/$dest" | \
        python3 -c "import sys,json; print(json.load(sys.stdin).get('sha',''))" 2>/dev/null)
    
    # base64编码
    content=$(base64 -w0 "$src")
    
    # 构建JSON
    if [ -n "$sha" ]; then
        json="{\"message\":\"Update $dest\",\"content\":\"$content\",\"sha\":\"$sha\"}"
    else
        json="{\"message\":\"Add $dest\",\"content\":\"$content\"}"
    fi
    
    result=$(curl -s -X PUT \
        -H "Authorization: Bearer $GITHUB_TOKEN" \
        -H "Content-Type: application/json" \
        "$API/repos/$GITHUB_USER/$REPO/contents/$dest" \
        -d "$json")
    
    if echo "$result" | python3 -c "import sys,json; d=json.load(sys.stdin); sys.exit(0 if 'content' in d or 'created' in d else 1)" 2>/dev/null; then
        echo "  ✅ $dest"
    else
        echo "  ❌ $dest: $(echo "$result" | python3 -c 'import sys,json; d=json.load(sys.stdin); print(d.get("message","error")[:50])' 2>/dev/null)"
    fi
}

# 推送所有文件
for f in $(find . -type f ! -path './.git/*' ! -path './node_modules/*' ! -path './dist/*' -name '*.astro' -o -type f ! -path './.git/*' ! -path './node_modules/*' ! -path './dist/*' -name '*.ts' -o -type f ! -path './.git/*' ! -path './node_modules/*' ! -path './dist/*' -name '*.js' -o -type f ! -path './.git/*' ! -path './node_modules/*' ! -path './dist/*' -name '*.json' -o -type f ! -path './.git/*' ! -path './node_modules/*' ! -path './dist/*' -name '*.md' | grep -v node_modules | grep -v '.git'); do
    dest="${f#./}"
    push_file "$f" "$dest"
done

echo "🎉 推送完成！"
