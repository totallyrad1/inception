FROM debian:latest

RUN apt-get update && \
    apt-get install -y nginx openssl expect && \
    apt-get clean

COPY . /src

WORKDIR /src

RUN rm /etc/nginx/nginx.conf
RUN mv conf/nginx.conf /etc/nginx/

EXPOSE 443

ENTRYPOINT ["./tools/init_nginx.sh"]
