#!/bin/bash
set -e

# 设置上游仓库 URL（建议在仓库中配置或作为参数传入）
UPSTREAM_URL="https://github.com/78/xiaozhi-esp32.git"
DEFAULT_BRANCH="main"

# 检查是否已存在 upstream remote
if ! git remote | grep -q upstream; then
    echo "添加 upstream 远程仓库..."
    git remote add upstream "$UPSTREAM_URL"
fi

# 获取上游最新代码
echo "获取 upstream 最新代码..."
git fetch upstream

# 切换到默认分支并合并 upstream 更新
echo "切换到 ${DEFAULT_BRANCH} 分支..."
git checkout ${DEFAULT_BRANCH}

echo "合并 upstream/${DEFAULT_BRANCH} 到 ${DEFAULT_BRANCH}..."
# 使用 --no-edit 自动合并，如果冲突则失败（后续可加入冲突处理逻辑）
if git merge upstream/${DEFAULT_BRANCH} --no-edit; then
    echo "合并成功，推送更新..."
    git push origin ${DEFAULT_BRANCH}
else
    echo "合并冲突，请手动解决冲突。"
    # 可选择创建 PR 或发送通知
    exit 1
fi