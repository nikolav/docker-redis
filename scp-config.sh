#!/bin/bash
APP_HOST=18.199.83.11
APP_PATH=/root/app/docker-redis

scp ./.env root@$APP_HOST:$APP_PATH
scp ./redis/redis.conf root@$APP_HOST:$APP_PATH/redis
