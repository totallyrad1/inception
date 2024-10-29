FROM debian:latest

RUN apt-get update && \
    apt-get install -y nginx && \
    apt-get clean

COPY . /src

WORKDIR /src

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]
