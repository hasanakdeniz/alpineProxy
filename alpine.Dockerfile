FROM alpine:latest

RUN apk update && \
    apk add --no-cache dante-server openssl && \
    rm -rf /var/cache/apk/*

RUN adduser -D -s /sbin/nologin test && \
    echo "test:$(openssl passwd -6 test)" | chpasswd -e

RUN rm -f /etc/sockd.conf && \
    echo "logoutput: stderr" > /etc/sockd.conf && \
    echo "internal: 0.0.0.0 port = 1080" >> /etc/sockd.conf && \
    echo "socksmethod: username" >> /etc/sockd.conf && \
    echo "user.privileged: root" >> /etc/sockd.conf && \
    echo "user.notprivileged: nobody" >> /etc/sockd.conf && \
    echo "" >> /etc/sockd.conf && \
    echo "client pass {" >> /etc/sockd.conf && \
    echo "  from: 0.0.0.0/0 to: 0.0.0.0/0" >> /etc/sockd.conf && \
    echo "  log: error connect" >> /etc/sockd.conf && \
    echo "}" >> /etc/sockd.conf && \
    echo "" >> /etc/sockd.conf && \
    echo "socks pass {" >> /etc/sockd.conf && \
    echo "  from: 0.0.0.0/0 to: 0.0.0.0/0" >> /etc/sockd.conf && \
    echo "  log: error connect" >> /etc/sockd.conf && \
    echo "}" >> /etc/sockd.conf && \
    chmod 644 /etc/sockd.conf

CMD ["/usr/sbin/sockd", "-D", "-f", "/etc/sockd.conf"]
