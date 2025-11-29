#!/bin/bash
APP_HOST=18.199.83.11
APP_PATH=/home/ubuntu/app/docker-redis
APP_USER=ubuntu

scp -i ~/.ssh/aws.key.bduhfbgwtxx.pem ./.env $APP_USER@$APP_HOST:$APP_PATH
scp -i ~/.ssh/aws.key.bduhfbgwtxx.pem ./redis/redis.conf $APP_USER@$APP_HOST:$APP_PATH/redis
