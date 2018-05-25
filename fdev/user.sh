#!/bin/sh
set -xeuo pipefail
# git-evtag isn't in EPEL, and anyways I switched to a shared homedir
exit 0
cd ~
gpg2 --import /usr/share/walters-gpg.txt
git config --global gpg.program gpg2
git clone https://github.com/cgwalters/homegit/ -b v2018.3
cd homegit
git-evtag verify v2018.3
make install
rm -f ~/.gitconfig
rm -f ~/.bash* && make install-dotfiles
ln -s /srv/walters/src ~/src
rm -f ~/.gnupg/S.*
