FROM alpine:latest

RUN apk add --no-cache ca-certificates wget unzip

RUN wget https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip && \
    unzip Xray-linux-64.zip && \
    mv xray /usr/local/bin/xray && \
    chmod +x /usr/local/bin/xray && \
    rm -rf Xray-linux-64.zip

# Pakai format JSON yang lebih rapi
RUN printf '{\n\
  "inbounds": [{\n\
    "port": 443,\n\
    "protocol": "vless",\n\
    "settings": {\n\
      "clients": [{"id": "6d2f9a1b-e8c4-4b3a-9d72-f5a81c0e92d7", "flow": "xtls-rprx-vision"}],\n\
      "decryption": "none"\n\
    },\n\
    "streamSettings": {\n\
      "network": "tcp",\n\
      "security": "reality",\n\
      "realitySettings": {\n\
        "show": false,\n\
        "dest": "www.microsoft.com:443",\n\
        "xver": 0,\n\
        "serverNames": ["www.microsoft.com"],\n\
        "privateKey": "GOnfV3U70jJjEOn9I0K9o3M4S_YpA1_YpA1_YpA1_Y0=",\n\
        "shortIds": ["6e7f8g9h"]\n\
      }\n\
    }\n\
  }],\n\
  "outbounds": [{"protocol": "freedom"}]\n\
}' > /etc/config.json

CMD ["xray", "-config", "/etc/config.json"]
