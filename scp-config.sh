#!/bin/bash

APP_HOST=108.61.179.22
APP_PATH=/root/app/docker-redis

scp ./.env root@$APP_HOST:$APP_PATH
scp ./redis/redis.conf root@$APP_HOST:$APP_PATH/redis
