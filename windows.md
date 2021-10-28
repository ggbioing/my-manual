[Regedit](#regedit)

[RemoteDesktop](#remotedesktop)

[WSL](#wsl)

### Regedit

Disable Edge at startup
```regedit
Windows Registry Editor Version 5.00
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NlaSvc\Parameters\Internet]
"EnableActiveProbing"=dword:00000000
```

### RemoteDesktop
Allow remote login without password:

run `gpedit.msc`
then go to "Computer Configuration > Administrative Templates > System > Credentials Delegation"
and disable "Restrict delegation of credentials to the remote servers".

Edit the register:
```regedit
Windows Registry Editor Version 5.00
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa]
"limitblankpassworduse"=dword:00000000
```

### WSL
Windows Subsystem for Linux

Symlink working both on WIN10 and WSL must be created in cmd.exe as follows:
```prompt
:: Run as Administrator
fsutil behavior query SymlinkEvaluation  :: check that remote to local is enabled, otherwise enable it
fsutil behavior set SymlinkEvaluation R2L:1
mklink [src] [dest] :: create symlink
mklink /d my_folder \\192.168.1.13\my_folder_on_network
```

mounting a network shared folder:
```bash
sudo mount -t drvfs '\\192.168.1.13\my_network_folder' $HOME/my_local_folder
```

GUI on WSL:
start an Xserver on Windows (e.g. [VcXsrv](https://sourceforge.net/projects/vcxsrv/)) then run on wsl:
```bash
export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0.0
export LIBGL_ALWAYS_INDIRECT=1
sudo /etc/init.d/dbus start &> /dev/null
```

