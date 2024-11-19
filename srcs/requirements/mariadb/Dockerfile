FROM debian:12

RUN apt-get update && \
    apt-get install -y mariadb-server expect && \
    apt-get clean

COPY . /src

WORKDIR /src

ENTRYPOINT ["./tools/init_mariadb.sh"]