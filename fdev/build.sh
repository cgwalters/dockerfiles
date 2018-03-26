#!/bin/sh
set -xeuo pipefail
name=$1
ctr=$(buildah from ${name}-base)
cleanup () {
    buildah rm ${ctr} || true
}
trap cleanup ERR
bldr() {
    buildah run ${ctr} -- "$@"
}
bldr /bin/sh -c 'cp /etc/skel/.bash* /root'
bldr useradd walters -G wheel,mock
bldr /bin/sh -c 'echo "walters ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers'
buildah copy ${ctr} config-user.sh /tmp/
bldr runuser -u walters /tmp/config-user.sh
bldr rm /tmp/config-user.sh
bldr /bin/sh -c 'rm -f ~/.bashrc && cd ~walters/homegit && make install-dotfiles'
# Hack around buildah not accepting arrays for entrypoint
bldr /bin/sh -c '(echo "#!/bin/sh" && echo "exec setpriv --reuid walters --regid walters --clear-groups -- env HOME=/home/walters chrt --idle 0 dumb-init /usr/bin/tmux -l") > /usr/bin/entrypoint && chmod a+x /usr/bin/entrypoint'
buildah config --env 'LANG=en_US.UTF-8' \
        --entrypoint /usr/bin/entrypoint ${ctr}
buildah commit ${ctr} ${name}
buildah rm ${ctr}
