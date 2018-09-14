#!/bin/sh

uid=$(stat -c %u /.aws)
gid=$(stat -c %g /.aws)

if [ $uid == 0 ] && [ $gid == 0 ]; then
    exec aws "$@"
fi

sed -i -r "s/aws-cli:x:\d+:\d+:/aws-cli:x:$uid:$gid:/g" /etc/passwd
sed -i -r "s/aws-cli:x:\d+:/aws-cli:x:$gid:/g" /etc/group

if [ $# -eq 0 ]; then
    exec su-exec aws-cli aws
else
    exec su-exec aws-cli aws "$@"
fi
