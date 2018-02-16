#!/bin/sh
set -xeuo pipefail
ctr=$(buildah from registry.fedoraproject.org/fedora:27)
bldr() {
    buildah run ${ctr} -- "$@"
}
# https://pagure.io/fedora-kickstarts/blob/a8e3bf46817ca30f0253b025fcd829a99b1eb708/f/fedora-docker-base.ks#_22
bldr sed -i '/tsflags=nodocs/d' /etc/dnf/dnf.conf
bldr yum -y install bash-completion yum-utils tmux sudo powerline \
    gcc clang ccache redhat-rpm-config make mock fedpkg \
    libvirt libguestfs-tools strace libguestfs-xfs \
    virt-install curl git kernel hardlink rsync \
    git-evtag {python3-,}dnf-plugins-core \
    origin-clients ostree{,-grub2} rpm-ostree \
    jq powerline gdb rust selinux-policy-targeted
bldr dnf builddep -y glib2 systemd ostree rpm-ostree
buildah copy ${ctr} *.sh /root/
buildah copy ${ctr} walters-gpg.txt /usr/share/walters-gpg.txt
buildah commit ${ctr} cgwalters/fdev-base
