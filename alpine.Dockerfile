FROM alpine:latest

RUN apk update && \
    apk add --no-cache dante-server openssl && \
    rm -rf /var/cache/apk/*

RUN adduser -D -s /sbin/nologin test && \
    echo "test:$(openssl passwd -6 test)" | chpasswd -e \
    rm -rf /etc/sockd.conf



CMD ["/usr/sbin/sockd", "-D", "-f", "/etc/sockd.conf"]
