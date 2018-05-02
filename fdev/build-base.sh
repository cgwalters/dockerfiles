#!/bin/sh
set -xeuo pipefail
base=$1
prefix=$2
tag=$3
ctr=$(buildah from ${base})

buildah copy ${ctr} *.sh /usr/lib/container/
buildah copy ${ctr} walters-gpg.txt /usr/share/walters-gpg.txt
buildah run ${ctr} -- /usr/lib/container/base.sh
buildah commit ${ctr} ${prefix}-base:${tag}
