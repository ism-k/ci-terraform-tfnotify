FROM hashicorp/terraform:0.12.10

ENV TFNOTIFY_VERSION=0.3.3
ENV GLIBC_VERSION=2.32-r0
ENV AWS_CLI_VERSION=2.0.30

RUN    apk add --update --no-cache --virtual .build-deps curl binutils \
    && curl -sL https://github.com/mercari/tfnotify/releases/download/v${TFNOTIFY_VERSION}/tfnotify_${TFNOTIFY_VERSION}_linux_amd64.tar.gz -o /tmp/tfnotify.tar.gz \
    && tar zxvf /tmp/tfnotify.tar.gz -C /tmp \
    && cp /tmp/tfnotify /usr/local/bin/tfnotify \
    && curl -sL https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub -o /etc/apk/keys/sgerrand.rsa.pub \
    && curl -sLO https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk \
    && curl -sLO https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-bin-${GLIBC_VERSION}.apk \
    && apk add --no-cache glibc-${GLIBC_VERSION}.apk glibc-bin-${GLIBC_VERSION}.apk \
    && curl -sL https://awscli.amazonaws.com/awscli-exe-linux-x86_64-${AWS_CLI_VERSION}.zip -o /tmp/awscliv2.zip \
    && unzip -qq /tmp/awscliv2.zip -d /tmp \
    && /tmp/aws/install \
    && rm -rf /tmp/* \
    && apk del --purge .build-deps
