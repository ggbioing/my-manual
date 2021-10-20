[RemoteDesktop](#remotedesktop)

### RemoteDesktop
Allow remote login without password:
```console
run: gpedit.msc
go to: Computer Configuration > Administrative Templates > System > Credentials Delegation
set: disable ‘Restrict delegation of credentials to the remote servers’
```
