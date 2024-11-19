FROM debian:12

RUN apt-get update && \
    apt-get install -y git golang build-essential wget && \
    apt-get clean

RUN wget https://github.com/google/cadvisor/releases/download/v0.39.3/cadvisor

RUN chmod +x cadvisor

CMD ["./cadvisor", "--port=8080"]