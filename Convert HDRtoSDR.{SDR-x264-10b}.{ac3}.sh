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

	echo "Convert HDRtoSDR.{SDR-x264-10b-30f}.{ac3}"
echo -------------------------========================-------------------------

	echo What it does ?
	echo "Convert ONE video file HDR to SDR"
echo -------------------------========================-------------------------

	echo Informations :
	echo "By LostByteSoft, no copyright or copyleft"
	echo "https://github.com/LostByteSoft"
	echo "Use ffmpeg only"
	echo "https://ffmpeg.org/ffmpeg.html"
	echo "Options https://trac.ffmpeg.org/wiki/Encode/H.264"
	echo "4k demo HDR https://4kmedia.org/"
	
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
	echo "Output file : "$NAME".{SDR-x264-10b-30f}.{ac3}"
	
	echo "Working dir : "$dir""
	export VAR="$FILE"
	echo Base directory : "$(dirname "${VAR}")"
	echo Selected file name: "$(basename "${VAR}")"
	
echo -------------------------========================-------------------------
## The code program.
echo "ffmpeg conversion"

### debug pixel info
### ffmpeg -h encoder=libx265 | grep pixel

### x264 8b preset

### good quality (Low) (x264 8bit)
### ffmpeg -i "$FILE" -vf zscale=t=linear:npl=100,format=gbrpf32le,zscale=p=bt709,tonemap=tonemap=hable:desat=0,zscale=t=bt709:m=bt709:r=tv,format=yuv420p -c:v libx264 -crf 25 -r:v 30 -an -preset superfast -tune fastdecode -max_muxing_queue_size 1024 "$NAME".{SDR.x264.8b}.{no.audio}.mkv

### compromis x264 (normal pc will do the job) (Medium) (x264 8bit)
### ffmpeg -i "$FILE" -vf zscale=t=linear:npl=100,format=gbrpf32le,zscale=p=bt709,tonemap=tonemap=hable:desat=0,zscale=t=bt709:m=bt709:r=tv,format=yuv420p -c:v libx264 -crf 20 -r:v 30 -an -preset superfast -tune fastdecode "$NAME".{SDR.x264.8b}.{no.audio}.mkv

###Better quality and x264 (Need a bigger PC) (medium) {SDR.x264.10b}"
ffmpeg -i "$FILE" -vf zscale=t=linear:npl=100,format=gbrpf32le,zscale=p=bt709,tonemap=tonemap=hable:desat=0,zscale=t=bt709:m=bt709:r=tv,format=yuv420p10le -c:v libx264 -crf 20 -r:v 30 -preset faster -tune fastdecode -c:a ac3 "$NAME".{SDR-x264-10b-30f}.{ac3}.mkv

### x265 10b presets

### better quality and x265 (Need a bigger PC) (Hi) (x265 10bit)
### ffmpeg -i "$FILE" -vf zscale=t=linear:npl=100,format=gbrpf32le,zscale=p=bt709,tonemap=tonemap=hable:desat=0,zscale=t=bt709:m=bt709:r=tv,format=yuv420p10le -c:v libx265 -crf 20 -r:v 30 -an -preset superfast -tune fastdecode "$NAME".{SDR.x265.10b}.{no.audio}.mkv

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
