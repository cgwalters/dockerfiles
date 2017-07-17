#!/bin/sh
set -xeuo pipefail
cat > /etc/yum.repos.d/atomic7-testing.repo << EOF
[atomic7-testing]
baseurl=http://cbs.centos.org/repos/atomic7-testing/x86_64/os/
gpgcheck=0
EOF
yum -y install yum-utils tmux sudo powerline \
    gcc clang redhat-rpm-config make mock fedpkg \
    libvirt libguestfs-tools strace libguestfs-xfs \
    virt-install curl git kernel hardlink \
    jq powerline gdb
yum-builddep -y glib2 systemd ostree rpm-ostree
