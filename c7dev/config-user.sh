#!/bin/sh
cd ~
set -xeuo pipefail
gpg --import /usr/share/walters-gpg.txt
git clone https://github.com/cgwalters/homegit/ -b v2017.1
cd homegit
rm -f ~/.bash* && make install-dotfiles
ln -s /srv/walters/src ~/src
