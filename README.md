# Hermes Agent Docker 部署

基于 [NousResearch/hermes-agent](https://github.com/NousResearch/hermes-agent) v0.12.0 的 Docker 部署方案。

镜像：`wsng911/hermes-agent:latest`（arm64 + amd64）

## 快速部署

```bash
# 1. 创建数据目录
mkdir -p /home/Hermes-agent

# 2. 复制配置文件
cp .env /home/Hermes-agent/.env
cp config.yaml /home/Hermes-agent/config.yaml

# 3. 编辑 .env 填入 API Key
nano /home/Hermes-agent/.env

# 4. 启动
docker compose up -d
```

## 常用命令

```bash
# 启动
docker compose up -d

# 停止
docker compose down

# 重启
docker compose restart

# 查看日志
docker logs -f hermes-agent

# 进入容器
docker exec -it hermes-agent bash

# 容器内运行配置向导
docker exec -it hermes-agent bash -c "source /opt/hermes/.venv/bin/activate && hermes setup"

# 切换模型
docker exec -it hermes-agent bash -c "source /opt/hermes/.venv/bin/activate && hermes model"

# 更新镜像
docker compose pull && docker compose up -d --force-recreate

# 查看资源占用
docker stats hermes-agent
```

## Telegram 常用命令

| 命令 | 说明 |
|------|------|
| 直接发消息 | 开始对话 |
| `/new` | 新会话 |
| `/model` | 切换模型 |
| `/skills` | 查看技能 |
| `/stop` | 中断任务 |
| `/usage` | Token 用量 |
| `/reset` | 重置会话 |

## 目录结构

```
/home/Hermes-agent/
├── .env          # API Key 配置
├── config.yaml   # 行为配置
├── SOUL.md       # Agent 人格
├── memories/     # 持久记忆
├── skills/       # 技能文件
├── sessions/     # 会话历史
├── logs/         # 运行日志
└── workspace/    # 工作目录
```
