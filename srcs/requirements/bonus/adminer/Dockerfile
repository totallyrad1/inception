FROM debian:latest

RUN apt-get update && \
    apt-get install -y adminer php curl && \
    apt-get clean

WORKDIR /usr/share/adminer/

CMD ["php", "-S", "0.0.0.0:8080", "adminer.php"]