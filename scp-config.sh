#!/usr/bin/env bash
set -euo pipefail

HOST=95.179.160.79
USER=root
SRC=/root/app/docker-redis
KEY_ID=id_ed25519_vultr

scp -i ~/.ssh/$KEY_ID ./.env $USER@$HOST:$SRC

ssh -i ~/.ssh/$KEY_ID $USER@$HOST "mkdir -p $SRC/redis" && \
  scp -i ~/.ssh/$KEY_ID ./redis/redis.conf $USER@$HOST:$SRC/redis/redis.conf
