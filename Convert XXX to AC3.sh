#!/bin/bash
#!/usr/bin/ffmpeg
printf '\033[8;50;100t'			# will resize the window, if needed.

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

echo "Convert ONE FILE to audio AC3"
echo "By LostByteSoft"
echo "Version 2021-12-30"
echo "Use ffmpeg only"

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

NAME=`echo "$FILE" | cut -d'.' -f1`
echo "Output file : "$NAME".{no-video}.{ac3-5.1-48000}.ac3"
echo "Your file is $FILE"

echo -----------------------------------------------------------------------------

ffmpeg -i "$FILE" -c:s copy -c:v copy -c:a ac3 "$NAME".{no-video}.{ac3-5.1-48000}.ac3

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
