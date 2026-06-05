#!/usr/bin/env bash
set -euo pipefail

IMAGE="0imbn7v6rkw/cache-redis"
NAME="cache-redis"

# remove old container if exists
docker rm -f "$NAME" >/dev/null 2>&1 || true \
&& docker run -d \
  --name "$NAME" \
  -p 6379:6379 \
  --env-file ./.env \
  -v redis-data:/data \
  --restart unless-stopped \
  --pull=always \
  --init \
  "$IMAGE"

# docker logs --tail=122 "$NAME"
# docker rm -f cache-redis
# docker system prune -a --volumes --force
