#!/bin/bash
#!/usr/bin/ffmpeg
printf '\033[8;50;150t'			# will resize the window, if needed.

echo --- Start of bash ---
## Software lead in
start=$SECONDS
now=$(date +"%Y-%m-%d_%A_%I:%M:%S")
echo "Current time : $now"

## Set working path.
# mypath=`realpath $0`
# cd `dirname $mypath`
dir=$(pwd)

echo -----------------------------------------------------------------------------
echo Version compiled on:
echo 2022-01-15_Saturday_07:13:09
echo -----------------------------------------------------------------------------
## Software name, what is this, version, informations."

echo "Convert ONE video file HDR to SDR"
echo "By LostByteSoft"
echo "Version 2022-01-04"
echo "Use ffmpeg only"
echo "https://ffmpeg.org/ffmpeg.html"
echo "Options https://trac.ffmpeg.org/wiki/Encode/H.264"
echo "4k demo HDR https://4kmedia.org/"

echo -----------------------------------------------------------------------------
echo "Select filename using dialog"

FILE="$(zenity --file-selection --filename=$HOME/$USER --title="Select a File")"

if test -z "$FILE"
	then
		echo "\$FILE is empty and now exit. You don't have selected a file."
		echo Press ENTER to continue.
		read name
		exit
	else
		echo "\$FILE is NOT empty."
		echo "You have selected "$FILE""
fi

echo -----------------------------------------------------------------------------
echo "Input name and output name"

NAME=`echo "$FILE" | cut -d'.' -f1`
echo "Output file : "$NAME".{SDR-x265-10b}.{no-audio}.mkv"

echo -----------------------------------------------------------------------------
echo "ffmpeg conversion"

### debug pixel info
### ffmpeg -h encoder=libx265 | grep pixel

### x264 8b preset

### good quality (Low) (x264 8bit)
### ffmpeg -i "$FILE" -vf zscale=t=linear:npl=100,format=gbrpf32le,zscale=p=bt709,tonemap=tonemap=hable:desat=0,zscale=t=bt709:m=bt709:r=tv,format=yuv420p -c:v libx264 -crf 25 -r:v 30 -an -preset superfast -tune fastdecode -max_muxing_queue_size 1024 "$NAME".{SDR.x264.8b}.{no.audio}.mkv

### compromis x264 (normal pc will do the job) (Medium) (x264 8bit)
### ffmpeg -i "$FILE" -vf zscale=t=linear:npl=100,format=gbrpf32le,zscale=p=bt709,tonemap=tonemap=hable:desat=0,zscale=t=bt709:m=bt709:r=tv,format=yuv420p -c:v libx264 -crf 20 -r:v 30 -an -preset superfast -tune fastdecode "$NAME".{SDR.x264.8b}.{no.audio}.mkv

###Better quality and x264 (Need a bigger PC) (medium) {SDR.x264.10b}"
### ffmpeg -i "$FILE" -vf zscale=t=linear:npl=100,format=gbrpf32le,zscale=p=bt709,tonemap=tonemap=hable:desat=0,zscale=t=bt709:m=bt709:r=tv,format=yuv420p10le -c:v libx264 -crf 20 -r:v 30 -an -preset superfast -tune fastdecode "$NAME".{SDR.x264.10b}.{no.audio}.mkv

### x265 10b presets

### better quality and x265 (Need a bigger PC) (Hi) (x265 10bit 30fps)
ffmpeg -i "$FILE" -vf zscale=t=linear:npl=100,format=gbrpf32le,zscale=p=bt709,tonemap=tonemap=hable:desat=0,zscale=t=bt709:m=bt709:r=tv,format=yuv420p10le -c:v libx265 -crf 20 -r:v 30 -an -preset superfast -tune fastdecode "$NAME".{SDR.x265.10b}.{no.audio}.mkv

## -preset ultrafast
## -preset medium

echo -----------------------------------------------------------------------------
## Software lead out.

	echo Finish... This script take $(( SECONDS - start )) seconds to complete.
	date=$(date -d@$(( SECONDS - start )) -u +%H:%M:%S)
	echo "Time needed: $date"
	now=$(date +"%Y-%m-%d_%A_%I:%M:%S")
	echo "Current time : $now"
	## Press enter or auto-quit here. Put ## in front of the next 3 lines.
	echo Press ENTER key to exit !
	read name
	exit

echo --- End of bash ---

	echo "Auto-quit in 10 sec."
	sleep 10
	exit
	
echo --- End of bash ---