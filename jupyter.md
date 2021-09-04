# Miscellaneous
---

<ins>Content:</ins>
- [Run Jupyter Notebook from server](#run-jupyter-notebook-from-server)
- [Ranger: Vim-key binding terminal File Browser](#ranger-vim-key-binding-terminal-file-browser)

---

## Run Jupyter Notebook from server

Locally, when we run `jupyter notebook`, 
the default browser will be launched with the link `localhost:8888` (a new tab with be opened if the browser is already running).
This gives you access to the jupyter notebook GUI.

The goal of this section is to open a `jupyter` session on the server (ex. nefgpu),
then link it to a local port, 
thus allowing you to work with `jupyer notebook` with the resource from NEF or IHUSUX (gpu, better cpu, dataset ...etc).

The following tutorial is based on the port tunneling tutorial from [FAQ - ClusterSophia](https://wiki.inria.fr/ClustersSophia/FAQ_new_config#How_can_i_tunnel_a_port_from_my_laptop_to_a_node_.3F).


**<ins>Tip:</ins>**

Jupyter session can also be used as: 
- **File Browser:** run `jupyter notebook /`, to get direct access to root folder.
- **File Transfer:** upload and download files.
- Graphic Text Editor: Useful when debugging script on the server (or you can just used `vim`.)
- *Pseudo* terminal multipliers: you can open as many terminals as you want.
- **File Reader:** replace `jupyter notebook` with [Jupyter Lab](https://jupyterlab.readthedocs.io/en/stable/), 
then it can be used as image viewer, csv reader, ...etc, along with `jupyter lab`'s library of useful extensions.
- :exclamation: **File Deletion:** you can also delete files using the jupyter GUI. 
However, the deletion work similar to local delete, as the deleted files are still store in `$HOME/.local/share/Trash`.
So you have to remove files from there as well to free up the space.

![jupyter_tools](../src/jupyter_tool.png)


**<ins>NEF</ins>**

- Step 1 (Server side): **Open oarsub interactive session with ssh key enabled**
	>Create a new ssh **private** key on the sever and copy to `~/.ssh/` folder on local computer.
	>```console
	>user@nef-devel:~$ ssh-keygen -f ~/.ssh/id_nef
	>```
	>_cf. see quick start guide for how to copy file with `rsync`._
	>
	>Run interactive session with option `-ki ~/.ssh/id_nef` and note the node number `XX` in `nefgpuXX`
	>```console
	>user@nef-devel:~$  oarsub -ki ~/.ssh/id_nef -I -p "mem>8000 and gpu='YES' and gpucapability>='0.5'" -l /gpunum=1,walltime=12
	>user@nefgpuXX:~$
	>```
	>
	>Run activate conda environment and run jupyter notebook with option `--no-browser --port=8887`.
	>```console
	>user@nefgpuXX:~$ conda activate env_nm
	>user@nefgpuXX:~$ jupyter notebook --no-browser --port=8887
	>```
	>Copied the token from the output, it will be needed later.
	>Leave interactive session and `jupyter` running.
	>
	>![jupyter_token](../src/jupyter_token.png)


- Step 2 (Local side): **Connecting to port=8887 to local port**

	>Add the following configuration to `~/.ssh/config` to direct connection to key `id_nef`.
	>You might need to create the `config` file.
	>``` console
	>Host *.neforward
	>    ProxyCommand ssh nef-frontal.inria.fr -W "$(basename %h .neforward):6667"
	>    LocalForward 8080 127.0.0.1:8080
	>    User oar
	>    Port 6667
	>    IdentityFile ~/.ssh/id_nef
	>```
	>
	>Link localhost:8880 (local) to localhost:8887 (server) with `ssh -N -L`. Replace `XX` with the node number.
	>``` console
	>user@local:~$ ssh -N -L localhost:8880:localhost:8887 nefgpuXX.neforward
	>```
	>
	>Open notebook session, in web browser using `localhost:8880`. 
	>Copy and paste the token, and it's good to go !
	>
	>![jupyter](../src/jupyter.png)

**<ins>IHU:</ins>**

Since, the session is not run via `oarsub`, 
we don't have to go through the ordeal with ssh config. 
The `jupyter` session can directly connected via `ssh -N -L`.

- Step 1 (server side): 
	> ```console
	> user@IHUSUX003:~$ jupyter notebook --no-browser --port=8887
	> ```

- Step 2 (local side): 
	> Link localhosts.
	> ```console
	> user@local:~$ ssh -N -L localhost:8880:localhost:8887 user@ip_address
	> ```
	> *`user@ip_address` as in `ssh user@ip_address` used to open IHUSUX session.*

Now, you can open `jupyter` session on web browser using `localhost:8880`.
Copy and Paste the `token` from the jupter session on the server if necessary __(see NEF section)__.

|*:point_up: All the port numbers can be changed, so long as it is correctly paired.*|
|---|

---

## Ranger: Vim-key binding terminal File Browser

[GitHub Link](https://github.com/ranger/ranger)

Ranger lets you browse and edit file on the terminal.
There are plenty of `ranger` cheat sheets online.
It might take sometime to get used to, but it can make life easier on the terminal 
and is definitely a better alternative than spamming `ls` every 3 seconds.


```console
user@server:~$ pip install ranger-fm
user@server:~$ ranger
```
![ranger](../src/ranger.png)


If you're not familiar with vim key binding, 
~~what are you doing with your life~~
the following are some basic commands you can do with ranger:

 Command | Key sequence |
 --- | ---
 Moving folder | Arrow keys or `h`:right `j`:down `k`:up and `l`:left
 Select/Unselect file | `space`
 Select All | `v`
 Unselect All | `uv`
 Copy highlight/selected file(s)/folder(s) | `yy`
 Cut highlight/selected file(s)/folder(s) | `dd`
 Paste file into current (middle) folder | `pp`
 Delete highlight/selected file(s)/folder(s) | `dD`
 Run shell command in current folder | `Ctrl+1`
 Run shell command on highlight/select file(s) | `Ctrl+2`


|:exclamation: Unlike the deletion with jupyter, the `dD` uses `rm` to remove file or folder, so once deleted the files are gone.|
|---|
