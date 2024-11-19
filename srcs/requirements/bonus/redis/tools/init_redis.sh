#!/usr/bin/expect

spawn sed -ie "s|bind 127.0.0.1 -::1|#bind 127.0.0.1 -::1|g" /etc/redis/redis.conf
expect eof

spawn sed -ie "s|# supervised auto|supervised no|g" /etc/redis/redis.conf
expect eof

exec redis-server /etc/redis/redis.conf --daemonize no --protected-mode no