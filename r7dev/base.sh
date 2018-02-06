#!/bin/sh
set -xeuo pipefail
sed -i '/tsflags=nodocs/d' /etc/yum.conf
cd /etc/pki/ca-trust/source/anchors
curl --insecure -o Red_Hat_IS_CA.crt https://password.corp.redhat.com/cacert.crt
for x in https://password.corp.redhat.com/RH-IT-Root-CA.crt \
         https://engineering.redhat.com/Eng-CA.crt \
         https://password.corp.redhat.com/pki-ca-chain.crt; do
    curl --insecure -O ${x}
done
update-ca-trust
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
cd /etc/yum.repos.d && curl -L -O http://download-node-02.eng.bos.redhat.com/rel-eng/RCMTOOLS/rcm-tools-rhel-7-workstation.repo
yum -y install yum-utils tmux sudo \
    gcc redhat-rpm-config make mock fedpkg \
    libvirt libguestfs-tools strace libguestfs-xfs \
    virt-install curl git kernel hardlink \
    jq powerline gdb
yum -y install rhpkg
yum-builddep -y glib2 systemd
