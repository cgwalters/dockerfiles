#!/bin/sh
cd ~
set -xeuo pipefail
gpg2 --import /usr/share/walters-gpg.txt
git config --global gpg.program gpg2
git clone https://github.com/cgwalters/homegit/ -b v2018.1
cd homegit
git-evtag verify v2018.1
make install
rm -f ~/.gitconfig
rm -f ~/.bash* && make install-dotfiles
ln -s /srv/walters/src ~/src
rm -f ~/.gnupg/S.*
