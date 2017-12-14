#!/bin/sh
set -xeuo pipefail
# https://pagure.io/fedora-kickstarts/blob/a8e3bf46817ca30f0253b025fcd829a99b1eb708/f/fedora-docker-base.ks#_22
sed -i '/tsflags=nodocs/d' /etc/dnf/dnf.conf
yum -y install bash-completion yum-utils tmux sudo powerline \
    gcc clang ccache redhat-rpm-config make mock fedpkg \
    libvirt libguestfs-tools strace libguestfs-xfs \
    virt-install curl git kernel hardlink rsync \
    git-evtag {python3-,}dnf-plugins-core \
    origin-clients ostree{,-grub2} rpm-ostree \
    jq powerline gdb rust
dnf builddep -y glib2 systemd ostree rpm-ostree
