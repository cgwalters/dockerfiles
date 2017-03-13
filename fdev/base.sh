#!/bin/sh
set -xeuo pipefail
dnf -y install yum-utils tmux sudo powerline \
    gcc redhat-rpm-config make mock fedpkg \
    libvirt libguestfs-tools libguestfs-xfs \
    virt-install curl git kernel hardlink \
    git-evtag {python3-,}dnf-plugins-core \
    jq powerline
dnf builddep -y glib2 systemd ostree rpm-ostree
