#!/bin/sh
cp /etc/skel/.bash* /root
useradd user
usermod -a -G wheel,mock user
echo 'user ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
