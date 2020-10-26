FROM alpine:3

RUN apk update && \
    apk add --no-cache bash curl jq coreutils && \
    rm -rf /var/cache/apk/*

ADD assets /opt/resource
RUN chmod +x /opt/resource/*

ENTRYPOINT [ "/bin/bash" ]
