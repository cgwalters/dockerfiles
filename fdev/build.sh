#!/bin/sh
set -xeuo pipefail
base=$1
prefix=$2
tag=$3
ctr=$(buildah from ${base})
cleanup () {
    buildah rm ${ctr} || true
}
trap cleanup ERR

buildah copy ${ctr} *.sh /usr/lib/container/
buildah copy ${ctr} repos/ /usr/lib/container/repos/
buildah copy ${ctr} walters-gpg.txt /usr/share/walters-gpg.txt
buildah run ${ctr} -- /usr/lib/container/base.sh
buildah run ${ctr} -- useradd walters -G wheel,mock
buildah run ${ctr} -- /bin/sh -c 'echo "walters ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers'
buildah run ${ctr} -- runuser -u walters /usr/lib/container/user.sh
buildah run ${ctr} -- cp -f /home/walters/.bashrc /root
# Hack around buildah not accepting arrays for entrypoint
buildah copy ${ctr} entrypoint.sh /usr/libexec/container-entrypoint
buildah config --env 'LANG=en_US.UTF-8' \
        --entrypoint /usr/libexec/container-entrypoint ${ctr}
buildah commit ${ctr} ${prefix}:${tag}
buildah rm ${ctr}
