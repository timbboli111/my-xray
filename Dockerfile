FROM alpine:latest
RUN apk add --no-cache ca-certificates wget unzip
RUN wget https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip && \
    unzip Xray-linux-64.zip && \
    mv xray /usr/local/bin/xray && \
    chmod +x /usr/local/bin/xray && \
    rm -rf Xray-linux-64.zip
COPY config.json /etc/config.json
CMD ["xray", "-config", "/etc/config.json"]
