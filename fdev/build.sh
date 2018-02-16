#!/bin/sh
set -xeuo pipefail
ctr=$(buildah from cgwalters/fdev-base)
cleanup () {
    buildah rm ${ctr} || true
}
trap cleanup ERR
bldr() {
    buildah run ${ctr} -- "$@"
}
bldr /bin/sh -c 'cp /etc/skel/.bash* /root'
bldr useradd user -G wheel,mock
bldr /bin/sh -c 'echo "user ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers'
buildah copy ${ctr} config-user.sh /tmp/
bldr runuser -u user /tmp/config-user.sh
bldr rm /tmp/config-user.sh
bldr /bin/sh -c 'rm -f ~/.bashrc && cd ~user/homegit && make install-dotfiles'
# Hack around buildah not accepting arrays for entrypoint
bldr /bin/sh -c '(echo "#!/bin/sh" && echo "exec chrt --idle 0 /usr/bin/tmux -l") > /usr/bin/entrypoint && chmod a+x /usr/bin/entrypoint'
buildah config ${ctr} --env 'LANG=en_US.UTF-8' \
        --entrypoint /usr/bin/entrypoint \
        --label RUN="docker run --init -ti --privileged -v /srv:/srv:rslave --net=host --name \${NAME} --env CONTAINER_NAME=\${NAME} \${IMAGE}"
buildah commit ${ctr} cgwalters/fdev
buildah rm ${ctr}
