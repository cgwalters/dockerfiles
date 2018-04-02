#!/bin/sh
set -xeuo pipefail
prefix=$1
tag=$2
ctr=$(buildah from ${prefix}-base:${tag})
cleanup () {
    buildah rm ${ctr} || true
}
trap cleanup ERR
bldr() {
    buildah run ${ctr} -- "$@"
}
bldr /bin/sh -c 'cp /etc/skel/.bash* /root'
bldr useradd walters -G wheel,mock
bldr /bin/sh -c 'echo "walters ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers'
buildah copy ${ctr} config-user.sh /tmp/
bldr runuser -u walters /tmp/config-user.sh
bldr rm /tmp/config-user.sh
bldr /bin/sh -c 'rm -f ~/.bashrc && cd ~walters/homegit && make install-dotfiles'
# Hack around buildah not accepting arrays for entrypoint
buildah copy ${ctr} entrypoint.sh /usr/libexec/container-entrypoint
buildah config --env 'LANG=en_US.UTF-8' \
        --entrypoint /usr/libexec/container-entrypoint ${ctr}
buildah commit ${ctr} ${prefix}:${tag}
buildah rm ${ctr}
