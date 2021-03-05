[briss](#briss)

[ffmpeg](#ffmpeg)

[ImageMagick](#imagemagick)

### BRISS
```bash
# tool to crop pdf
wget http://garr.dl.sourceforge.net/project/briss/release%200.9/briss-0.9.tar.gz
java -Xms512m -Xmx4096m -jar briss-0.9.jar
```

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
# -vf colorchannelmixer=.3:.4:.3:0:.3:.4:.3:0:.3:.4:.3
# Seppia
# colorchannelmixer=.393:.769:.189:0:.349:.686:.168:0:.272:.534:.131
```

### ImageMagick
```bash
# add text
convert -pointsize 18 -fill white -draw "text 0,18 '$id'" ${id}_T1_GM_Jac.png test.jpg && eog test.jpg

# IMAGE INFO
identify -verbose rose.jpg
convert -density 600 pg_0001.pdf -blur 2 -colorspace Gray -depth 1 -compress Group4 up.png

# Human Brain Mapping
# aprire le imag con gimp e togliere quell'alpha channel (Layer > Transparency > Remove Alpha Channel)
convert -profile sRGB.icc <image in> -profile USWebCoatedSWOP.icc -colorspace cmyk -density 600 -geometry 3900x <image out>

convert -negate <in> <out> # invert image

convert -delay 150 -dispose 2 -geometry 800x496 -size 800x496 *.png oceandrain.gif
convert +level-colors Firebrick, me.jpg oldme.jpg # Mark Zuckerburg could've saved a billion if he knew about ImageMagick.
convert -fill "#FFFFFF" -opaque "#141414" -fuzz 20% <(curl -s -L http://bit.ly/nUKKfA ) illusion-fix.jpg # Replace dark grays with white
convert -size 1280x720 plasma:fractal background.png # Create a 1280x720 color plasma image. Different each time.
convert -rotate -90 sideways.jpg rightsideup.jpg

convert A.eps -transparent white B.png # remove white

-size 320x85 canvas:none -font Bookman-DemiItalic -pointsize 72

# GIF
convert -delay 0 -loop 0 -alpha set -dispose background *.png ani.gif
convert -dispose background test-{59..135}.png ani.gif
convert -crop 663X600+0+113 +repage dual.gif cropped.gif

# morphing
convert original/*.jpg -delay 20 -morph 10 new/img%03d.jpg

# unsharp mask
convert -unsharp 5.0x10+1.0+0.0 <input file> <output file>

# PDF to Images
pdftk *.pdf cat output whole.pdf

pdftk whole.pdf burst

gs -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -dSAFER -dFirstPage=1 -dLastPage=4 -sOutputFile=outputT4.pdf T4.pdf
gs -sDEVICE=pswrite -dNOCACHE -sOutputFile=- -q -dbatch -dNOPAUSE -dQUIET filename.ps -c quit | ps2pdf - "`echo filename.ps | cut -f1 -d'.'`"-nofont.pdf

convert -density 600 in.pdf out.png
convert -gravity NorthEast -crop 9650x6550+0+0 pg_0200.jpg trim.jpg

# High compresison image to pdf
convert image.gif -alpha off [ -monochrome | -colorspace Gray -depth 2 ]-compress Zip -quality 100 -units PixelsPerInch -density 600  image_deflate.pdf
convert image.gif -alpha off -monochrome -compress Group4 -quality 100 -units PixelsPerInch -density 600  image_group4.pdf
# histogram
convert pg_0254.png  -format %c -depth 8  histogram:info:histogram_image.txt
awk '{print $1}' histogram_image.txt | sed 's/://g' | gnuplot plot.gp
# keep only black
convert pg_0010.png -fill white -fuzz 50% +opaque "#000000" result.png
# ALL IN ONE
convert -density 600 IN.pdf -fill white -fuzz 50% +opaque "#000000"  -alpha off -monochrome -compress Group4 -quality 100 -units PixelsPerInch OUT.pdf
```

