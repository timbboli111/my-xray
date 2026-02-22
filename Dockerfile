FROM debian:stable-slim

RUN apt update && \
    apt install -y ca-certificates wget unzip && \
    rm -rf /var/lib/apt/lists/*

# Pindah ke tempat kerja
WORKDIR /usr/local/bin

# Download Xray
RUN wget https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip && \
    unzip Xray-linux-64.zip && \
    chmod +x xray && \
    rm -f Xray-linux-64.zip

# BUAT FOLDER DULU BIAR COPY NGGAK ERROR
RUN mkdir -p /etc/xray

# Copy config ke folder yang baru dibuat
COPY config.json /etc/xray/config.json

# Jalankan Xray
CMD ["xray", "-c", "/etc/xray/config.json"]
