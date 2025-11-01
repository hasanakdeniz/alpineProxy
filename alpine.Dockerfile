FROM alpine:latest

RUN apk update && \
    apk add --no-cache bash nano && \
    rm -rf /var/cache/apk/*

CMD ["/bin/bash"]
