FROM alpine:latest

RUN apk add --no-cache ca-certificates wget unzip

RUN wget https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip && \
    unzip Xray-linux-64.zip && \
    mv xray /usr/local/bin/xray && \
    chmod +x /usr/local/bin/xray && \
    rm -rf Xray-linux-64.zip

# Config Reality (Port 443, Nyamar ke Microsoft)
RUN echo '{\
  "inbounds": [{\
    "port": 443,\
    "protocol": "vless",\
    "settings": {\
      "clients": [{"id": "6d2f9a1b-e8c4-4b3a-9d72-f5a81c0e92d7", "flow": "xtls-rprx-vision"}],\
      "decryption": "none"\
    },\
    "streamSettings": {\
      "network": "tcp",\
      "security": "reality",\
      "realitySettings": {\
        "show": false,\
        "dest": "www.microsoft.com:443",\
        "xver": 0,\
        "serverNames": ["www.microsoft.com", "images.weserv.nl"],\
        "privateKey": "uLp-XXXX-Pake-Punyamu-Ganti-Nanti-Ya",\
        "shortIds": ["6e7f8g9h"]\
      }\
    }\
  }],\
  "outbounds": [{"protocol": "freedom"}]\
}' > /etc/config.json

# Karena PrivateKey di atas cuma contoh, Erika saranin pake yang ini:
RUN sed -i 's|uLp-XXXX-Pake-Punyamu-Ganti-Nanti-Ya|GOnfV3U70jJjEOn9I0K9o3M4S_YpA1_YpA1_YpA1_Y0=|' /etc/config.json

CMD ["xray", "-config", "/etc/config.json"]
