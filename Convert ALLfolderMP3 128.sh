#!/bin/bash
#!/usr/bin/ffmpeg
start=$SECONDS
now=$(date +"%Y-%m-%d_%A_%I:%M:%S")
echo "Current time : $now"
echo --- Start of bash ---
sleep 0.5				# Leave time to windows to reseize.
printf '\033[8;50;125t'		# will resize the window

echo -----------------------------------------------------------------------------

echo "Convert ALL audio/video file in folder to audio mp3"
echo "By LostByteSoft"
echo "Version 2021-12-16"
echo "Use ffmpeg only"

echo -----------------------------------------------------------------------------

echo You must put this file in the same directory of the file you want to extract !
echo Be careful it will extract ALL video MKV file in the directory.
echo Press ENTER to continue.
echo -----------------------------------------------------------------------------
read name

for i in *.*;
  do name=`echo "$i" | cut -d'.' -f1`
  echo "$name"
  ffmpeg -i "$i" "${name}.mp3"
done

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
