#!/usr/bin/bash
set -xeuo pipefail
# Set up runtime directories
mkdir -m 0700 -p /run/user/0
mkdir -m 0700 -p /run/user/1000 && chown 1000:1000 /run/user/1000
export XDG_RUNTIME_DIR=/run/user/1000
echo ${container} > /run/container
exec setpriv --reuid 1000 --regid 1000 --clear-groups -- env HOME=/home/walters chrt --idle 0 dumb-init /usr/bin/tmux -l
