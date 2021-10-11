[fstab](#fstab)

### fstab

Append to the `/etc/fstab` file:
```bash
# Virtual Box Shared Folders
C_DRIVE /mnt/c                                                    vboxsf  uid=1000,gid=1000 0 0
F_DRIVE /mnt/f                                                    vboxsf  uid=1000,gid=1000 0 0
# Windows Shared FOlder
//192.168.1.13/Folder_X path_to_mount_point                       cifs    uid=1000,gid=1000,credentials=/home/user/.credentials 0 0
```
Fill `/home/user/.credentials` (`chmod 600`) accordingly:
```bash
user=...
password=...
```

