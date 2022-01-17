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

echo "Convert ONE video file to x265 30 fps ac3, all others settings remain unchange"
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
echo "Output file : "$NAME".{x265-30fps}.{ac3}.mkv"

echo -----------------------------------------------------------------------------
echo "ffmpeg conversion"

### debug pixel info
### ffmpeg -h encoder=libx265 | grep pixel

### -ar 44100 -ac 2 -b:a 192k
### -c:a aac -strict -2

ffmpeg -i "$FILE" -c:v libx265 -r:v 30 -c:a ac3 "$NAME".{x265-30fps}.{ac3}.mkv
# ffmpeg -i "$FILE" -c:v libx265 -r:v 30 -c:a copy "$NAME".{x265-30fps}.{copy}.mkv

echo -----------------------------------------------------------------------------
### Software lead out.

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
