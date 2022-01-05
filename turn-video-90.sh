#!/usr/bin/ffmpeg
#!/bin/bash
start=$SECONDS
now=$(date +"%Y-%m-%d_%A_%I:%M:%S")
echo "Current time : $now"
echo --- Start of bash ---
sleep 0.5				# Leave time to windows to reseize.
printf '\033[8;50;125t'		# will resize the window

echo -----------------------------------------------------------------------------

echo "Turn a video 90 deg"
echo "By LostByteSoft"
echo "Version 2021-07-17"
echo "Use ffmpeg only"

echo -----------------------------------------------------------------------------

echo "Select filename using dialog"
FILE="$(zenity --file-selection --filename=$HOME/$USER --title="Select a File")"

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

echo "GO !"

echo -----------------------------------------------------------------------------

ffmpeg -i "$FILE" -vf "transpose=2" ""$FILE"-OUT.mp4"

echo -----------------------------------------------------------------------------

	echo Finish... exing
	echo Press ENTER to continue.
	read name

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
