FROM hashicorp/terraform:0.12.10

ENV TFNOTIFY_VERSION=0.3.3

RUN    apk add --update --no-cache --virtual .build-deps curl \
    && curl -sL https://github.com/mercari/tfnotify/releases/download/v${TFNOTIFY_VERSION}/tfnotify_${TFNOTIFY_VERSION}_linux_amd64.tar.gz -o /tmp/tfnotify.tar.gz \
    && tar zxvf /tmp/tfnotify.tar.gz -C /tmp \
    && cp /tmp/tfnotify /usr/local/bin/tfnotify \
    && rm -rf /tmp/* \
    && apk del --purge .build-deps
