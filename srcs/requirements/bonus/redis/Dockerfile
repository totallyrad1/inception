FROM debian:12

RUN apt-get update && \
    apt-get install -y ssh redis-server expect && \
    apt-get clean

COPY . /src

WORKDIR /src

ENTRYPOINT [ "./tools/init_redis.sh" ]