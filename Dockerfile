FROM debian:stable-slim

RUN apt update && \
    apt install -y ca-certificates wget unzip && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /usr/local/bin

RUN wget https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip && \
    unzip Xray-linux-64.zip && \
    chmod +x xray && \
    rm -f Xray-linux-64.zip

RUN mkdir -p /etc/xray
COPY config.json /etc/xray/config.json

# Sesuaikan EXPOSE ke 443 biar sama kayak config pertama kita
EXPOSE 443

CMD ["/usr/local/bin/xray", "run", "-c", "/etc/xray/config.json"]
