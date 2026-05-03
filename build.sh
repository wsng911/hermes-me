#!/bin/bash
# Hermes Agent 多架构镜像构建脚本
# 用法: ./build.sh [版本号]  例如: ./build.sh v0.13.0

set -e

VERSION=${1:-latest}
IMAGE="wsng911/hermes-agent"
SRC_DIR="$HOME/Documents/hermes-agent"

echo "==> 拉取最新代码..."
cd "$SRC_DIR"
git pull

echo "==> 当前版本: $(grep '^version' pyproject.toml)"

echo "==> 构建并推送 arm64 镜像..."
docker buildx build \
  --builder multiarch \
  --platform linux/arm64 \
  --push \
  --cache-from "type=registry,ref=${IMAGE}:buildcache" \
  --cache-to   "type=registry,ref=${IMAGE}:buildcache,mode=max" \
  -t "${IMAGE}:${VERSION}" \
  -t "${IMAGE}:latest" \
  .

echo "==> 完成: ${IMAGE}:${VERSION}"
docker buildx imagetools inspect "${IMAGE}:${VERSION}" | grep Platform
