FROM alpine:3.8

ENV AWS_CLI_VERSION=1.16.14 \
    AWS_SHARED_CREDENTIALS_FILE=/.aws/credentials \
    AWS_CONFIG_FILE=/.aws/config

RUN apk --no-cache add \
        ca-certificates \
        groff \
        less \
        python \
        su-exec \
    && apk --no-cache add --virtual .build-deps \
        py-pip \
        py-setuptools \
    && pip --no-cache-dir install awscli==${AWS_CLI_VERSION} \
    && apk del .build-deps \
    && addgroup aws-cli \
    && adduser -D -h / -s /bin/sh -G aws-cli aws-cli

VOLUME /.aws
VOLUME /project

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
