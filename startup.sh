#!/bin/bash
apt -y update
apt install -y samba
useradd smbuser -s /usr/sbin/nologin
(echo "a";echo "a") | smbpasswd -a -s smbuser
mkdir /srv/samba
mkdir /srv/samba/timemachine
chown -R samba /srv/samba
chmod -R 777 /srv/samba
service smbd start
service nmbd start

