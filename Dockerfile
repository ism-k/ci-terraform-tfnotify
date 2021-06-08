ARG TF_VERSION
FROM hashicorp/terraform:${TF_VERSION}

ARG TFNOTIFY_VERSION
ARG GLIBC_VERSION
ARG AWS_CLI_VERSION

RUN    apk --upgrade --no-cache add curl && apk add --upgrade --no-cache --virtual .build-deps binutils \
    &&  if [ "$TFNOTIFY_VERSION" \> "0.5.0" ]; then \
            curl -sL "https://github.com/mercari/tfnotify/releases/download/v${TFNOTIFY_VERSION}/tfnotify_linux_amd64.tar.gz" -o /tmp/tfnotify.tar.gz;  \
        elif [ "$TFNOTIFY_VERSION" \> "0.3.1" ]; then \
            curl -sL "https://github.com/mercari/tfnotify/releases/download/v${TFNOTIFY_VERSION}/tfnotify_${TFNOTIFY_VERSION}_linux_amd64.tar.gz" -o /tmp/tfnotify.tar.gz;  \
        else \
            curl -sL "https://github.com/mercari/tfnotify/releases/download/v${TFNOTIFY_VERSION}/tfnotify_v${TFNOTIFY_VERSION}_linux_amd64.tar.gz" -o /tmp/tfnotify.tar.gz; \
        fi \
    && tar -zxvf /tmp/tfnotify.tar.gz -C /tmp \
    && if [ "$TFNOTIFY_VERSION" \> "0.3.1" ]; then \
            cp /tmp/tfnotify /usr/local/bin/tfnotify; \
        else \
            cp /tmp/tfnotify_v${TFNOTIFY_VERSION}_linux_amd64/tfnotify /usr/local/bin/tfnotify; \
        fi \
    && if [ -n "$GLIBC_VERSION" ]; then \
            curl -sL https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub -o /etc/apk/keys/sgerrand.rsa.pub \
            && curl -sLO https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk \
            && curl -sLO https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-bin-${GLIBC_VERSION}.apk \
            && apk add --no-cache glibc-${GLIBC_VERSION}.apk glibc-bin-${GLIBC_VERSION}.apk; \
        fi \
    && if [ -n "$AWS_CLI_VERSION" ]; then \
            curl -sL https://awscli.amazonaws.com/awscli-exe-linux-x86_64-${AWS_CLI_VERSION}.zip -o /tmp/awscliv2.zip \
            && unzip -qq /tmp/awscliv2.zip -d /tmp \
            && /tmp/aws/install; \
        fi \
    && rm -rf /tmp/* \
    && apk del --purge .build-deps
