#!/bin/bash
	printf '\033[8;40;100t'			# will resize the window, if needed.
	#printf '\033[8;40;200t'		# will resize the window, if needed.

## -----===== Start of bash =====-----
	## Software lead in
	start=$SECONDS
	now=$(date +"%Y-%m-%d_%A_%I:%M:%S")
	echo "Current time : $now"

echo -------------------------========================-------------------------
## Software name, what is this, version, informations.

	echo "Convert XXX to {720p-x264-8b-30f}.{aac-2.0-44100hz-160k}"
echo -------------------------========================-------------------------

	echo What it does ?
	echo "Convert ONE video file to 720p x264 8bit aac-2.0 44100"
echo -------------------------========================-------------------------

	echo Informations :
	echo "By LostByteSoft, no copyright or copyleft"
	echo "https://github.com/LostByteSoft"
	echo "Use ffmpeg only"
echo "https://ffmpeg.org/ffmpeg.html"
	
echo -------------------------========================-------------------------
echo Version compiled on:
echo 2022-01-20_Thursday_01:33:25
echo -------------------------========================-------------------------
echo "Select filename using dialog !"

	FILE="$(zenity --file-selection --filename=$HOME/$USER --title="Select a File")"

if test -z "$FILE"
	then
		echo "You don't have selected a file, now exit."
		echo Press ENTER to continue.
		read name
		exit
	else
		echo "You have selected :"
		echo "$FILE"
fi

echo -------------------------========================-------------------------
echo "Input name and output name"

	## Set working path.
	# mypath=`realpath $0`
	# cd `dirname $mypath`
	dir=$(pwd)

	NAME=`echo "$FILE" | cut -d'.' -f1`
	echo "Output file : "$NAME".{720p-x264-8b-30f}.{aac-2.0-44100hz-160k}.mkv"
	
	echo "Working dir : "$dir""
	export VAR="$FILE"
	echo Base directory : "$(dirname "${VAR}")"
	echo Selected file name: "$(basename "${VAR}")"
	
echo -------------------------========================-------------------------
## The code program.
echo "ffmpeg conversion"

### debug pixel info
### ffmpeg -h encoder=libx265 | grep pixel

### -ar 44100 -ac 2 -b:a 192k
### -c:a aac -strict -2

#ffmpeg -i "$FILE" -vf scale=1280:720,format=yuv420p -c:v libx264 -crf 20 -r:v 30 -c:a aac -ar 44100 -ac 2 -b:a 160k "$NAME".{720p-x264-8b-30f}.{aac-2.0-44100hz}.mkv

ffmpeg -i "$FILE" -vf scale=1280x720:flags=lanczos,format=yuv420p -c:v libx264 -crf 20 -r:v 30 -c:a aac -ar 44100 -ac 2 -b:a 160k "$NAME".{720p-x264-8b-30f}.{aac-2.0-44100hz-160k}.mkv

### ffmpeg -i "$FILE" -s hd720 -c:v libx264 -crf 25 -c:a aac -ar 44100 -ac 2 -b:a 160k "$NAME".{720p-x264-8bit}.{aac-2.0-44100}.mkv

## -preset ultrafast
## -preset medium

echo -------------------------========================-------------------------
## Software lead out.

	echo "Finish..."
	echo "This script take $(( SECONDS - start )) seconds to complete."
	date=$(date -d@$(( SECONDS - start )) -u +%H:%M:%S)
	echo "Time needed: $date"
	now=$(date +"%Y-%m-%d_%A_%I:%M:%S")
	echo "Current time : $now"
	
echo -------------------------========================-------------------------
## Press enter or auto-quit here.

	### Put ## in front of the next 3 lines if you want to auto-quit.
	echo Press ENTER key to exit !
	read name
	exit
	
	echo "Auto-quit in 5 sec."
	sleep 5
	exit

echo -------------------------========================-------------------------
## End-user license agreement (eula)

JUST DO WHAT YOU WANT WITH THE PUBLIC LICENSE

Version 3.1415926532 (January 2022)

TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
   
Everyone is permitted to copy and distribute verbatim or modified copies of
this license document.

As is customary and in compliance with current global and interplanetary
regulations, the author of these pages disclaims all liability for the
consequences of the advice given here, in particular in the event of partial
or total destruction of the material, Loss of rights to the manufacturer
warranty, electrocution, drowning, divorce, civil war, the effects of radiation
due to atomic fission, unexpected tax recalls or encounters with
extraterrestrial beings elsewhere.

LostByteSoft no copyright or copyleft we are in the center.

## -----===== End of bash =====-----
