FROM alpine:3.8

ENV VERSYNC_VERSION 1.2.4
ENV GLIBC_VERSION 2.30-r0

RUN apk add --no-cache --update-cache --update curl ca-certificates \
    && curl -o /tmp/glibc.apk -L "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk" \
    && curl -o /tmp/glibc-bin.apk -L "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-bin-${GLIBC_VERSION}.apk" \
    && apk add --allow-untrusted /tmp/glibc.apk  \
    && apk add --allow-untrusted /tmp/glibc-bin.apk  \
    && wget http://releases.verysync.com/releases/v${VERSYNC_VERSION}/verysync-linux-amd64-v${VERSYNC_VERSION}.tar.gz \
    && tar zxvf verysync-linux-amd64-v${VERSYNC_VERSION}.tar.gz \
    && mkdir /data \
    && rm -rf /var/cache/apk/* /tmp/* /var/tmp/* verysync-linux-amd64-v${VERSYNC_VERSION}.tar.gz
    
WORKDIR /verysync-linux-amd64-v${VERSYNC_VERSION}

VOLUME /data

EXPOSE 8886 22330

ENTRYPOINT ["./verysync","-gui-address","0.0.0.0:8886"]
