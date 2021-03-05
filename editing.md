[ffmpeg](#ffmpeg)

### ffmpeg
```bash
 # info
 ffprobe file.mp4
 ffmpeg -i file.mp4
 
 # https://launchpad.net/~mc3man/+archive/ubuntu/trusty-media
 add-apt-repository ppa:mc3man/trusty-media
 apt-get update
 apt-get dist-upgrade
 rm -r ~/.config/vlc
 
 # space cropping
 ffmpeg -i in.mp4 -filter:v "crop=width:height:x:y" out.mp4
 
 # time cropping
 ffmpeg -i videoIn.mp4 -ss 1:00 -to 2:00 -vn -acodec 'copy' audioOut.aac
 
 # normalize if not @ 0 dB
 ffmpeg -i file.aac -af "volumedetect" -f null /dev/null
 ffmpeg -i video.avi -af "volumedetect" -vn -sn -dn -f null /dev/null
 
 
 ffmpeg -i 01-A_Teardrop_To_The_Sea.flac -acodec aac -strict -2 01-A_Teardrop_To_The_Sea.aac
 # dmn : in windows use "Screen Recorder" to capture the screen
 ffmpeg -i dmn_pt13_.avi -qscale 0 -ss 0:12 -to 0:40 -filter:v "crop=633:846:1269:182,setpts=0.5*PTS" dmn_pt13.avi
 ffmpeg -i dmn_pt13_.avi -qscale 0 -filter:v "setpts=0.5*PTS" dmn_pt13s.avi
 
 # merge video audio
 ffmpeg -i VID_20170717_201300.mp4 -i STE-003.wav -c:v copy -c:a aac -strict experimental -map 0:v:0 -map 1:a:0 output.mp4
 ffmpeg -itsoffset 00:07.0 -i VID_20170717_201300.mp4 -i STE-003.wav -map 0:0 -map 1:0 -acodec aac -strict -2 -vcodec copy      -ss 9.0 -to 3:42.0 output.mp4
 
 # concatenate
 ffmpeg -f concat -safe 0 -i mylist.txt -c copy output  # mylist.txt contains lines such as: file 'video.mp4'
 
 # video and audio from 2 different videos
 ffmpeg -i input_0.mp4 -i input_1.mp4 -c copy -map 0:v:0 -map 1:a:0 -shortest out.mp4
 
 # MP3
 ffmpeg -i IN.avi -vn -acodec libmp3lame -ar 48000 -ac 2 [-b:a 192k | -q:a 2] OUT.mp3
 
 # VOB vob
 cat *VOB > movie.vob
 ffmpeg -analyzeduration 100M -probesize 100M -i movie.vob  # find possible hidden tracks by analyzing not just few sample     s
 ffmpeg -i movie.vob movie.mp4  # default configuration used
 
 # Squeeze smartphone videos
 ffmpeg -i goodnight_moon.mp4 -c:v libx264 -crf 25 -c:a libmp3lame -ar 44100 -ac 1 -b:a 128k output.mp4
 
 # Multiple subtitles
 ffmpeg -i Input.mp4 -i ita.srt -i eng.srt -i esp.srt -map 0:0 -map 0:1 -map 1 -map 2 -map 3 -c:v copy -c:a copy -c:s srt      -metadata:s:s:0 language=Italian -metadata:s:s:1 language=English -metadata:s:s:2 language=Spanish Output.mkv
 
 # Multiple audio tracks
 ffmpeg -i Contagion.mp4 -i Contagion_ITA.mp4 -map 0:0 -map 1:1 -map 0:1 -c:v copy -c:a copy -metadata:s:a:0 language=Ital     ian -metadata:s:a:1 language=French output.mkv
 
 # Grayscale
 -vf colorchannelmixer=.3:.4:.3:0:.3:.4:.3:0:.3:.4:.3
 # Seppia
 colorchannelmixer=.393:.769:.189:0:.349:.686:.168:0:.272:.534:.131
```

