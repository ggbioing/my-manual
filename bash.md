BASH
====

POSIX parameter expansion
-------------------------

```
+--------------------+----------------------+-----------------+-----------------+
|                    |       parameter      |     parameter   |    parameter    |
|                    |   Set and Not Null   |   Set But Null  |      Unset      |
+--------------------+----------------------+-----------------+-----------------+
| ${parameter:-word} | substitute parameter | substitute word | substitute word |
| ${parameter-word}  | substitute parameter | substitute null | substitute word |
| ${parameter:=word} | substitute parameter | assign word     | assign word     |
| ${parameter=word}  | substitute parameter | substitute null | assign word     |
| ${parameter:?word} | substitute parameter | error, exit     | error, exit     |
| ${parameter?word}  | substitute parameter | substitute null | error, exit     |
| ${parameter:+word} | substitute word      | substitute null | substitute null |
| ${parameter+word}  | substitute word      | substitute word | substitute null |
+--------------------+----------------------+-----------------+-----------------+
```

`${var+x}` is a parameter expansion which evaluates to nothing if var is unset and substitutes the string x otherwise.

**Script Example**

```bash
#!/urs/bin/env bash
bn=$(basename "$fullfile")
ext="${bn##*.}"
fn="${bn%.*}"
lowercase="${bn,,}"
uppercase="${bn^^}"
Alternatively, you can focus on the last '/' of the path instead of the '.' which should work even if you have unpredictable file extensions:
fn="${fullfile##*/}"
# epoch + nanoseconds
tempVar=$(date +%s%N)
tempVar=$(date +%Y-%m-%d_%H:%m:%S)

cat << EOF > test.txt
set terminal png
set output "test.png"
set yrange [0:200e3]
plot "<cat"
EOF
```

.bashrc
-------

source: [https://wiki.archlinux.org/index.php/Color_Bash_Prompt_(Italiano)]

```bash
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;37m\][\[\033[01;36m\]\u\[\033[01;37m\]@\[\033[01;32m\]\h\[\033[00m\]:\[\033[01;33m\]\W\[\033[01;37m\]]\[\033[00m\] '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\W\$ '
fi
```

**Colors**

```
Black       0;30     Dark Gray     1;30
Blue        0;34     Light Blue    1;34
Green       0;32     Light Green   1;32
Cyan        0;36     Light Cyan    1;36
Red         0;31     Light Red     1;31
Purple      0;35     Light Purple  1;35
Brown       0;33     Yellow        1;33
Light Gray  0;37     White         1;37
# Background
On_Black='\e[40m'       # Nero
On_Red='\e[41m'         # Rosso
On_Green='\e[42m'       # Verde
On_Yellow='\e[43m'      # Giallo
On_Blue='\e[44m'        # Blu
On_Purple='\e[45m'      # Purple
On_Cyan='\e[46m'        # Ciano
On_White='\e[47m'       # Bianco
```