#!/bin/sh
set -xeuo pipefail
cat > /etc/yum.repos.d/rhel-server-internal.repo << EOF
[rhel7-server]
baseurl=http://download-node-02.eng.bos.redhat.com/nightly/latest-RHEL-7/compose/Server/x86_64/os/
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release
enabled=1
[rhel7-server-source]
baseurl=http://download-node-02.eng.bos.redhat.com/nightly/latest-RHEL-7/compose/Server/source/tree/
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release
enabled=0
[rhel7-server-optional]
baseurl=http://download-node-02.eng.bos.redhat.com/nightly/latest-RHEL-7/compose/Server-optional/x86_64/os/
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release
enabled=1
[rhel7-server-extras]
baseurl=http://download-node-02.eng.bos.redhat.com/nightly/EXTRAS-RHEL-7.4/latest-EXTRAS-7-RHEL-7/compose/Server/x86_64/os/
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release
enabled=1
EOF
yum -y install yum-utils tmux sudo \
    gcc redhat-rpm-config make mock fedpkg \
    libvirt libguestfs-tools strace libguestfs-xfs \
    virt-install curl git kernel hardlink \
    jq powerline gdb
yum-builddep -y glib2 systemd
