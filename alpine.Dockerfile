FROM alpine:latest

ARG AUSER=user
ARG APASSWORD=pass

# Gerekli paketleri kur ve kullanıcıyı ekle
RUN apk update && \
    apk add dante-server bash && \
    adduser -D -s /sbin/nologin $AUSER && \
    echo "$AUSER:$APASSWORD" | chpasswd && \
    rm -rf /var/cache/apk/*

# Dante Konfigürasyonu
RUN echo "logoutput: stderr" > /etc/sockd.conf && \
    echo "internal: eth0 port = 1080" >> /etc/sockd.conf && \
    echo "external: eth0" >> /etc/sockd.conf && \
    echo "clientmethod: none" >> /etc/sockd.conf && \
    echo "socksmethod: username" >> /etc/sockd.conf && \
    echo "client pass { from: 0.0.0.0/0 to: 0.0.0.0/0 }" >> /etc/sockd.conf && \
    echo "socks pass { from: 0.0.0.0/0 to: 0.0.0.0/0 protocol: tcp }" >> /etc/opppsockd.conf && \
    echo "socks pass { from: 0.0.0.0/0 to: 0.0.0.0/0 protocol: udp }" >> /etc/sockd.conf && \
    echo "socks block { from: 0.0.0.0/0 to: 0.0.0.0/0 }" >> /etc/sockd.conf

EXPOSE 1080

# 🚨 Düzeltme: -D bayrağını kaldırıp ön planda tutmaya zorluyoruz
CMD ["/usr/sbin/sockd", "-f"]
