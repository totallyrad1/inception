FROM debian:12

RUN apt-get update && \
    apt-get install -y nginx openssl expect gettext-base && \
    apt-get clean

COPY . /src

WORKDIR /src

RUN rm /etc/nginx/nginx.conf
RUN mv /src/conf/nginx.conf /etc/nginx/

EXPOSE 443

ENTRYPOINT ["./tools/init_nginx.sh"]
