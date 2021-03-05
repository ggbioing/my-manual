[conda](#conda)

[cron](#cron)

[curl](#curl)

[date](#date)

<a href="file_compression.md" target="_blank">file compression</a>:
	[7z](file_compression.md#7z){:target="_blank"}

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

### Conda
```bash
conda update -n base conda
conda info --envs
conda env create -f environment.yml
conda list
conda env remove --name myenv
conda env export > environment.yml
```

### Cron
```bash
# DAEMON SCRIPT
#!/bin/bash
while [ 1 -eq 1 ]; do
# do some stuff
sleep 5
done
# CRON SCRIPT
#!/bin/bash
OUTPUT=`ps -ef | grep ‘[b]ash_daemon\.sh’`
if [ “$OUTPUT” ]
then
echo running
else
/home/jeff/bin/bash_daemon.sh
fi
# edit crontab
* * * * * /home/jeff/bin/bash_cron.sh 	> /dev/null 2>&1

# dropbox backup
7 23 * * *	rsync -av --delete /home/luigi/Dropbox /home/luigi/BACKUPS/Dropbox/daily/
37 23 * * 0	rsync -av --delete /home/luigi/Dropbox /home/luigi/BACKUPS/Dropbox/weekly/
1 22 1 * *	tar -c /home/luigi/Dropbox | /home/luigi/.linuxbrew/bin/pbzip2 -c > /home/luigi/BACKUPS/Dropbox/monthly_$(/bin/date +\%F).tar.bz2
# http://www.cyberciti.biz/faq/linux-execute-cron-job-after-system-reboot/
```

### Curl
```bash
# check HTTP response code
if [[ $(curl -s -o /dev/null -I -w "%{http_code}" http://biobank.ctsu.ox.ac.uk/crystal/index.cgi) == "3"?? ]] && echo "redirection"
# use proxy
curl --proxy http://192.168.100.62:8080 "http://surfer.nmr.mgh.harvard.edu/fswiki/MatlabRuntime?action=AttachFile&do=get&target=runtime2012bLinux.tar.gz" -o "runtime2012b.tar.gz"
# sharepoint
curl --ntlm -u DOMAIN/user https://sharepoint.domain.com/path/to/file
```

### Date
```bash
sudo dpkg-reconfigure tzdata
# behind proxy
sudo date -s "$(curl -sD - google.com | grep '^Date:' | cut -d' ' -f3-)"
# epoch + nanoseconds
date +%s%N
```
