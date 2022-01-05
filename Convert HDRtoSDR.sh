#!/bin/bash
#!/usr/bin/ffmpeg
start=$SECONDS
now=$(date +"%Y-%m-%d_%A_%I:%M:%S")
echo "Current time : $now"
echo --- Start of bash ---
sleep 0.5			# Leave time to windows to reseize.
printf '\033[8;50;125t'		# will resize the window

echo -----------------------------------------------------------------------------

echo "Convert ONE video file HDR to SDR"
echo "By LostByteSoft"
echo "Version 2022-01-04"
echo "Use ffmpeg only"

echo -----------------------------------------------------------------------------

echo "Select filename using dialog"
FILE="$(zenity --file-selection --filename=$HOME/$USER --title="Select a File")"

#echo "Your file is $FILE"

echo -----------------------------------------------------------------------------

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

sleep 1

echo -----------------------------------------------------------------------------

### ffmpeg -i "$FILE" -c:s copy -c:v copy -strict experimental -c:a dts "$FILE".dts

ffmpeg -i "$FILE" -vf zscale=t=linear:npl=100,format=gbrpf32le,zscale=p=bt709,tonemap=tonemap=hable:desat=0,zscale=t=bt709:m=bt709:r=tv,format=yuv420p -c:v libx264 -crf 25 -r:v 30 -c:a copy -preset ultrafast -tune fastdecode -max_muxing_queue_size 1024 "$FILE"_SDR.mkv

### ffmpeg -i "$FILE" -vf zscale=t=linear:npl=100,format=gbrpf32le,zscale=p=bt709,tonemap=tonemap=hable:desat=0,zscale=t=bt709:m=bt709:r=tv,format=yuv420p -c:v libx265 -crf 22 -preset medium -tune fastdecode "$FILE".mkv

echo -----------------------------------------------------------------------------

	echo Finish... This script take $(( SECONDS - start )) seconds to complete.
	date=$(date -d@$(( SECONDS - start )) -u +%H:%M:%S)
	echo "Time needed: $date"
	now=$(date +"%Y-%m-%d_%A_%I:%M:%S")
	echo "Current time : $now"
	echo Press ENTER key to exit !
	read name
	exit

echo --- End of bash ---
