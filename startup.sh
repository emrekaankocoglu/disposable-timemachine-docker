#!/bin/bash
apt -y update
apt install -y samba
# required change in samba config
echo "[global]
	min protocol = SMB2
	vfs objects = fruit streams_xattr  
	fruit:metadata = stream
	fruit:model = MacSamba
	fruit:posix_rename = yes 
	fruit:veto_appledouble = no
	fruit:wipe_intentionally_left_blank_rfork = yes 
	fruit:delete_empty_adfiles = yes 
	workgroup = WORKGROUP
	server string = %h server (Samba, Ubuntu)
	log file = /var/log/samba/log.%m
	max log size = 1000
	logging = file
	panic action = /usr/share/samba/panic-action %d
	server role = standalone server
	obey pam restrictions = yes
	unix password sync = yes
	passwd program = /usr/bin/passwd %u
	passwd chat = *Enter\snew\s*\spassword:* %n\n *Retype\snew\s*\spassword:* %n\n *password\supdated\ssuccessfully* .
	pam password change = yes
	map to guest = bad user

[timemachine]
	comment = Timemachine
	path = /srv/samba/timemachine
	read only = no
	browseable = yes
	writeable = yes
	guest ok = yes
	guest user = smbuser
	force user = smbuser
	create mode = 0777
  directory mode = 0777
	vfs objects = fruit streams_xattr
	fruit:time machine = yes">/etc/samba/smb.conf
useradd smbuser -s /usr/sbin/nologin
(echo "a";echo "a") | smbpasswd -a -s smbuser
mkdir /srv/samba
mkdir /srv/samba/timemachine
#owning the share is needed for timemachine backups
chown -R smbuser /srv/samba
chmod -R 777 /srv/samba
service smbd start
service nmbd start
#since the existing entrypoint is overwritten, the old entrypoint is executed at the end-found by inspecting the original container from linuxserver
/init
