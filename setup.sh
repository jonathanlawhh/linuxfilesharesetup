#!/bin/bash
# Auto setup fileshare for APU enviroment

echo Download required package
sudo apt -y install winbind libpam-winbind libnss-winbind krb5-config samba
echo Copying required SMB Config
sudo cp smb.conf /etc/samba/smb.conf
echo Copying required NSSWITCH Config
sudo cp nsswitch.conf /etc/nsswitch.conf
echo -
echo Enter your username to join domain
read username
net ads join -U $username