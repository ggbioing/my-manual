[SSH](#server)

[ssh](#server)

### Server
Install openssh-server:
```bash
dnf install openssh-server
```
Activate the server:
```bash
systemctl start sshd  # only for the current session
systemctl  enable sshd.service  # automatic server startup at boot time
```
