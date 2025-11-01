FROM alpine:latest

RUN apk update && \
    apk add --no-cache bash nano openrc dante-server && \
    rm -rf /var/cache/apk/*

RUN adduser -D -s /sbin/nologin test && echo "test:$(openssl passwd -6 test)" | chpasswd -e

CMD ["/bin/bash"]
