FROM debian:latest

RUN apt-get update && \
    apt-get install -y mariadb-server && \
    apt-get clean

COPY . /src

WORKDIR /src

CMD ["echo", "mariadb up"]