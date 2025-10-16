#!/bin/bash

APP_HOST=45.76.88.13
APP_PATH=/root/app/docker-redis

scp ./.env root@$APP_HOST:$APP_PATH
scp ./redis/redis.conf root@$APP_HOST:$APP_PATH/redis
