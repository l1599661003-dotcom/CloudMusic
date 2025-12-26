#!/bin/bash
set -e

if [ -z "$TENCENT_SECRET_ID" ] || [ -z "$TENCENT_SECRET_KEY" ]; then
  echo "请配置 SECRET_ID 和 SECRET_KEY"
  exit 1
fi

echo "Serverless 版本："
serverless --version

# 如果你还需要保留 geturl / config 合并逻辑，可以留
# ⚠️ 但不要再用 sls

python ./serverless/createyml.py

echo "开始部署到腾讯云 SCF"

serverless deploy \
  --stage ${STAGE} \
  --region ${REGION} \
  --verbose

echo -e "\033[1;32m部署成功 \033[0m"
