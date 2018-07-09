#!/bin/bash
# Auto setup fileshare for APU enviroment

echo Download required package
sudo apt -y install winbind libpam-winbind libnss-winbind krb5-config samba
echo Copying required SMB Config
sudo cp smb.conf /etc/samba/smb.conf
echo Copying required NSSWITCH Config
sudo cp nsswitch.conf /etc/nsswitch.conf
echo -
echo Enter your username to join domain, eg jonathan.law
read username
net ads join -U $username
echo - 
echo -

echo Making file share directory...
echo Creating /home/jon/fileserver/pub
echo Creating /home/jon/fileserver/sub
sudo mkdir -p /home/jon/fileserver/{pub,sub}
echo -

echo Applying proper permissiong for domain user to access
sudo chmod -R 0770 /home/jon/fileserver/
sudo chgrp -R "Domain Users@techlab" /home/jon/fileserver
echo -

echo Starting services...
sudo /etc/init.d/winbind restart
sudo /etc/init.d/nmbd restart
sudo /etc/init.d/smbd restart

