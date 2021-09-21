[wsl](#wsl)


### WSL
Windows Subsystem for Linux

Symlink in WIN10
```prompt
:: Run as Administrator
fsutil behavior query SymlinkEvaluation  :: check that remote to local is enabled, otherwise enable it
fsutil behavior set SymlinkEvaluation R2L:1
mklink [src] [dest] :: create symlink
mklink /d my_folder \\192.168.1.13\my_folder_on_network
```

On WSL mount it directly:
```bash
sudo mount -t drvfs '\\192.168.1.13\my_network_folder' $HOME/my_local_folder
```

