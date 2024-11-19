FROM debian:12

RUN apt-get update && \
    apt-get install -y expect vsftpd systemd openssh-server && \
    apt-get clean

COPY . /src

WORKDIR /src

ENTRYPOINT ["./tools/init_ftp.sh"]