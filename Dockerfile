FROM golang:1.16.2-alpine3.13

RUN set -xe \
    && apk add --no-cache -Uu attr curl ca-certificates wget ffmpeg gnupg python3 \
    && curl -Lo /usr/local/bin/youtube-dl https://yt-dl.org/downloads/latest/youtube-dl \
    && curl -Lo /tmp/youtube-dl.sig https://yt-dl.org/downloads/latest/youtube-dl.sig \
    && gpg --keyserver keyserver.ubuntu.com --recv-keys '7D33D762FD6C35130481347FDB4B54CBA4826A18' \
    && gpg --keyserver keyserver.ubuntu.com --recv-keys 'ED7F5BF46B3BBED81C87368E2C393E0F18A9236D' \
    && gpg --verify /tmp/youtube-dl.sig /usr/local/bin/youtube-dl \
    && chmod a+rx /usr/local/bin/youtube-dl \
    && ln -s /usr/bin/python3 /usr/bin/python \
    && apk del --purge gnupg \
    && rm -rf /var/cache/apk/* /tmp/*

RUN mkdir /.cache \
    && chmod 777 /.cache

ENV SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt
