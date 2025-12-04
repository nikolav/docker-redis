FROM redis:7.4.7-bookworm

# Ensure data directory exists with the right permissions
RUN mkdir -p /data \
    && chown -R redis:redis /data

COPY ./redis/redis.conf /usr/local/etc/redis/redis.conf

VOLUME ["/data"]

EXPOSE 6379

WORKDIR /data

CMD ["redis-server", "/usr/local/etc/redis/redis.conf"]
