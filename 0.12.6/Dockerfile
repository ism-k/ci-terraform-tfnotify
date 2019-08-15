FROM hashicorp/terraform:0.12.6

ENV TFNOTIFY_VERSION=0.3.1

RUN    apk add --update --no-cache --virtual .build-deps curl \
    && curl -sL https://github.com/mercari/tfnotify/releases/download/v${TFNOTIFY_VERSION}/tfnotify_v${TFNOTIFY_VERSION}_linux_amd64.tar.gz -o /tmp/tfnotify.tar.gz \
    && tar zxvf /tmp/tfnotify.tar.gz -C /tmp \
    && cp /tmp/tfnotify_v${TFNOTIFY_VERSION}_linux_amd64/tfnotify /usr/local/bin/tfnotify \
    && rm -rf /tmp/* \
    && apk del --purge .build-deps
