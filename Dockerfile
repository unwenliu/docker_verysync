FROM alpine:3.9

ENV VERSYNC_VERSION 2.5.5
ENV GLIBC_VERSION 2.26-r0
# 设置时区
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories
RUN apk add --no-cache tzdata \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && rm -rf /var/cache/apk/* /tmp/* /var/tmp/* $HOME/.cache

# 安装软件
RUN apk add --no-cache --update-cache --update curl ca-certificates \
    && curl -o /tmp/glibc.apk -L "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk" \
    && curl -o /tmp/glibc-bin.apk -L "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-bin-${GLIBC_VERSION}.apk" \
    && apk add --allow-untrusted /tmp/glibc.apk  \
    && apk add --allow-untrusted /tmp/glibc-bin.apk  \
    && wget http://releases-cdn.verysync.com/releases/v${VERSYNC_VERSION}/verysync-linux-arm-v${VERSYNC_VERSION}.tar.gz \
    && tar zxvf verysync-linux-arm-v${VERSYNC_VERSION}.tar.gz \
    && mkdir /data \
    && rm -rf /var/cache/apk/* /tmp/* /var/tmp/* verysync-linux-arm-v${VERSYNC_VERSION}.tar.gz
    
WORKDIR /verysync-linux-arm-v${VERSYNC_VERSION}

VOLUME /data

EXPOSE 8886 22330

ENTRYPOINT ["./verysync","-gui-address","0.0.0.0:8886"]
