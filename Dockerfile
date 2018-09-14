FROM alpine:3.8 as builder

ENV AWS_CLI_VERSION 1.16.14

RUN apk --no-cache add \
        ca-certificates \
        groff \
        less \
        python \
    && apk --no-cache add --virtual .build-deps \
        py-pip \
        py-setuptools \
    && pip --no-cache-dir install awscli==${AWS_CLI_VERSION} \
    && apk del .build-deps

VOLUME /root/.aws
VOLUME /project

ENTRYPOINT ["aws"]
