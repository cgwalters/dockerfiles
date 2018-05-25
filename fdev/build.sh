#!/bin/sh
set -xeuo pipefail
prefix=$1
tag=$2
ctr=$(buildah from ${prefix}-base:${tag})
cleanup () {
    buildah rm ${ctr} || true
}
trap cleanup ERR

buildah copy ${ctr} user.sh /usr/lib/container/
buildah run ${ctr} -- useradd walters -G wheel,mock
buildah run ${ctr} -- /bin/sh -c 'echo "walters ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers'
buildah run ${ctr} -- runuser -u walters /usr/lib/container/user.sh
# Hack around buildah not accepting arrays for entrypoint
buildah copy ${ctr} entrypoint.sh /usr/libexec/container-entrypoint
buildah config --env 'LANG=en_US.UTF-8' \
        --entrypoint /usr/libexec/container-entrypoint ${ctr}
buildah commit ${ctr} ${prefix}:${tag}
buildah rm ${ctr}
