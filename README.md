### User Management

System user: no password login or home:
```bash
sudo useradd --system <user>
sudo usermod -L <user> # lock to prevent logging
```
Without a home directory:
```bash
sudo useradd myuser
```
With home directory:
```bash
sudo useradd -m myuser
sudo passwd myuser
```
Then set the shell:
```bash
sudo usermod -s /bin/bash myuser
```
Heres the command I almost always use:
```bash
NEWUSER='username'  && sudo useradd -d /home/$NEWUSER -s /bin/bash -m $NEWUSER
```

### Group Management
```bash
chgrp scratch temp/  # setting the folder /temp as 'scratch'
chmod g+s temp/  # every file creating under temp will be 'scratch'
```

add user to a group:
```bash
groupadd $GROUP
getent group $GROUP # check if group exist
sudo useradd -d /var/ftp/IT-biomarkapd -s /sbin/nologin -m IT-biomarkapd
usermod -a -G $GROUP $USER
adduser $USER $GROUP [e.g. sudo]
```

vsftp "no delete" rigths:
```bash
useradd -d /var/vsftp/ASL -s /usr/sbin/nologin -m brescia
usermod -a -G asl brescia
```
