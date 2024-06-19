[mplayer](#mplayer)

# mplayer

Use "alsa" if there are problems with "pulseaudio".
`sudo` needed.
```bash
sudo mplayer -shuffle -volume 30 -loop 0 -ao alsa:device=hw=0.0 -playlist playlist.txt
```

