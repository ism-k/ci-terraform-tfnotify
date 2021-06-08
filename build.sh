#!/bin/sh
set -eu

tail -n +2 versions.txt | \
while read -r TF_VERSION TFNOTIFY_VERSION GLIBC_VERSION AWS_CLI_VERSION; do\
    cat <<EOF
build $TF_VERSION

TF_VERSION=$TF_VERSION
TFNOTIFY_VERSION=$TFNOTIFY_VERSION
GLIBC_VERSION=$GLIBC_VERSION
AWS_CLI_VERSION=$AWS_CLI_VERSION

EOF

    docker build . -t "gunosy/ci-terraform-tfnotify:$TF_VERSION" \
        --build-arg TF_VERSION="$TF_VERSION" \
        --build-arg TFNOTIFY_VERSION="$TFNOTIFY_VERSION" \
        --build-arg GLIBC_VERSION="$GLIBC_VERSION" \
        --build-arg AWS_CLI_VERSION="$AWS_CLI_VERSION"
    docker push gunosy/ci-terraform-tfnotify:${TF_VERSION}

    echo -e "\n\n"
done
