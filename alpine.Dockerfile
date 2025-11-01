FROM alpine:latest

ARG AIP=eth0
ARG AUSER=user
ARG APASSWORD=pass

RUN apk update && \
    apk add dante-server bash && \
    adduser -D -s /sbin/nologin $AUSER && \
    echo "$AUSER:$APASSWORD" | chpasswd && \
    rm -rf /var/cache/apk/*

RUN echo "logoutput: stderr" > /etc/sockd.conf && \
    echo "internal: 0.0.0.0 port = 1080" >> /etc/sockd.conf && \
    # 🚨 Gerekli Düzeltme: Dışarı çıkış için eth0'ı belirtin
    echo "external: eth0" >> /etc/sockd.conf && \
    echo "clientmethod: none" >> /etc/sockd.conf && \
    echo "socksmethod: username" >> /etc/sockd.conf && \
    echo "client pass { from: 0.0.0.0/0 to: 0.0.0.0/0 }" >> /etc/sockd.conf && \
    echo "socks pass { from: 0.0.0.0/0 to: 0.0.0.0/0 protocol: tcp }" >> /etc/sockd.conf && \
    echo "socks pass { from: 0.0.0.0/0 to: 0.0.0.0/0 protocol: udp }" >> /etc/sockd.conf && \
    echo "socks block { from: 0.0.0.0/0 to: 0.0.0.0/0 }" >> /etc/sockd.conf

EXPOSE 1080

CMD ["sh"]
