#!/bin/sh
set -xeuo pipefail
yum -y install bash-completion yum-utils tmux sudo powerline \
    gcc clang ccache redhat-rpm-config make mock fedpkg \
    libvirt libguestfs-tools strace libguestfs-xfs \
    virt-install curl git kernel hardlink rsync \
    git-evtag {python3-,}dnf-plugins-core \
    origin-clients ostree{,-grub2} rpm-ostree \
    jq powerline gdb
dnf builddep -y glib2 systemd ostree rpm-ostree
