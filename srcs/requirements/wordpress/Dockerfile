FROM debian:latest

RUN apt-get update && \
    apt-get install -y php php-fpm curl expect php-mysqli && \
    apt-get clean

COPY . /

WORKDIR /var/www/inception

ENTRYPOINT [ "/tools/init_wp.sh" ]