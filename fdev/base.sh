#!/bin/sh
set -xeuo pipefail

dn=$(cd $(dirname $0) && pwd)

# https://pagure.io/fedora-kickstarts/blob/a8e3bf46817ca30f0253b025fcd829a99b1eb708/f/fedora-docker-base.ks#_22
for f in /etc/dnf/dnf.conf /etc/yum.conf; do
    if test -f ${f}; then
        pkgconf=${f}
    fi
done
if test -n "${pkgconf:-}"; then
    sed -i '/tsflags=nodocs/d' ${pkgconf}
fi

OS_ID=$(. /etc/os-release && echo ${ID})
OS_VER=$(. /etc/os-release && echo ${VERSION_ID})

override_repo="/usr/lib/container/repos/${OS_ID}-${OS_VER}.repo"
if test -f "${override_repo}"; then
    cp --reflink=auto "${override_repo}" /etc/yum.repos.d
fi

case "${OS_ID}" in
    rhel|centos) yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm;
                 pkg_builddep="yum-builddep"
                 # for dumb-init
                 (cd /etc/yum.repos.d && curl -L -O https://copr.fedorainfracloud.org/coprs/walters/walters-ws-misc/repo/epel-7/walters-walters-ws-misc-epel-7.repo)
                 ;;
    *) pkg_builddep="dnf builddep";;
esac

pkgs="dumb-init ansible bash-completion yum-utils tmux sudo powerline \
     gcc clang ccache redhat-rpm-config make mock fedpkg \
     vagrant-libvirt libguestfs-tools strace libguestfs-xfs \
     virt-install curl git kernel rsync awscli \
     git-evtag jq gdb rust golang selinux-policy-targeted"
if test "${OS_ID}" = fedora; then
    pkgs="$pkgs "$(echo {python3-,}dnf-plugins-core)
    pkgs="$pkgs origin-clients standard-test-roles"
    pkgs="$pkgs "$(echo ostree{,-grub2} rpm-ostree)
fi
yum -y install $pkgs
${pkg_builddep} -y glib2 systemd
if test "${OS_ID}" = fedora; then
    ${pkg_builddep} -y ostree rpm-ostree origin
fi
yum clean all

