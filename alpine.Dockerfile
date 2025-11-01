FROM alpine:latest

RUN apk update && \
    apk add dante-server && \
    rm -rf /var/cache/apk/*

RUN echo "logoutput: stderr" > /etc/sockd.conf && \
    echo "internal: 0.0.0.0 port = 1080" >> /etc/sockd.conf && \
    echo "external: eth0" >> /etc/sockd.conf && \
    echo "clientmethod: none" >> /etc/sockd.conf && \
    echo "socksmethod: none" >> /etc/sockd.conf && \
    echo "client pass { from: 0.0.0.0/0 to: 0.0.0.0/0 }" >> /etc/sockd.conf && \
    echo "socks pass { from: 0.0.0.0/0 to: 0.0.0.0/0 }" >> /etc/sockd.conf

EXPOSE 1080

CMD ["sockd", "-D"]
