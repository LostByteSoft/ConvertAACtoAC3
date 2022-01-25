#!/bin/bash
#!/usr/bin/ffmpeg
## -----===== Start of bash =====-----

	#printf '\033[8;40;100t'	# will resize the window, if needed.
	printf '\033[8;40;125t'		# will resize the window, if needed.

	## Software lead in
	start=$SECONDS
	now=$(date +"%Y-%m-%d_%A_%I:%M:%S")
	echo "Current time : $now"

echo -------------------------========================-------------------------
## Software name, what is this, version, informations.
	echo "Convert HDRtoSDR.{SDR-x264-10b-30f}.{ac3-48000hz-640k}"
echo -------------------------========================-------------------------
	echo What it does ?
	echo "Convert ONE video file HDR to SDR {SDR-x264-10b-30f}.{ac3-48000hz-640k}"
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
	echo 2022-01-21_Friday_08:24:06
echo -------------------------========================-------------------------
echo "Select filename using dialog !"

	file="$(zenity --file-selection --filename=$HOME/$USER --title="Select a file")"

if test -z "$file"
	then
		echo "You don't have selected a file, now exit."
		echo Press ENTER to continue.
		read name
		exit
	else
		echo "You have selected :"
		echo "$file"
fi

echo -------------------------========================-------------------------
echo "Input name, directory and output name :"

	## Set working path.
	dir=$(pwd)
	
	echo Input file : "$file"
	
	echo "Working dir : "$dir""
	export VAR="$file"
	echo Base directory : "$(dirname "${VAR}")"
	echo Base name: "$(basename "${VAR}")"
	
	## Output file name
	name=`echo "$file" | rev | cut -f 2- -d '.' | rev` ## remove extension
	echo "Output file : "$name".{SDR-x264-10b-30f}.{ac3-48000hz-640k}.mkv"

echo -------------------------========================-------------------------
## The code program.
echo "ffmpeg conversion"

### debug pixel info
### ffmpeg -h encoder=libx265 | grep pixel

### x264 8b preset

### good quality (Low) (x264 8bit)
### ffmpeg -i "$file" -vf zscale=t=linear:npl=100,format=gbrpf32le,zscale=p=bt709,tonemap=tonemap=hable:desat=0,zscale=t=bt709:m=bt709:r=tv,format=yuv420p -c:v libx264 -crf 25 -r:v 30 -an -preset superfast -tune fastdecode -max_muxing_queue_size 1024 "$NAME".{SDR.x264.8b}.{no.audio}.mkv

### compromis x264 (normal pc will do the job) (Medium) (x264 8bit)
### ffmpeg -i "$file" -vf zscale=t=linear:npl=100,format=gbrpf32le,zscale=p=bt709,tonemap=tonemap=hable:desat=0,zscale=t=bt709:m=bt709:r=tv,format=yuv420p -c:v libx264 -crf 20 -r:v 30 -an -preset superfast -tune fastdecode "$NAME".{SDR.x264.8b}.{no.audio}.mkv

###Better quality and x264 (Need a bigger PC) (medium) {SDR.x264.10b}"
ffmpeg -i "$file" -vf zscale=t=linear:npl=100,format=gbrpf32le,zscale=p=bt709,tonemap=tonemap=hable:desat=0,zscale=t=bt709:m=bt709:r=tv,format=yuv420p10le -c:v libx264 -crf 20 -r:v 30 -preset faster -tune fastdecode -c:a ac3 -ar 48000 -b:a 640k "$NAME".{SDR-x264-10b-30f}.{ac3-48000hz-640k}.mkv

### x265 10b presets

### better quality and x265 (Need a bigger PC) (Hi) (x265 10bit)
### ffmpeg -i "$file" -vf zscale=t=linear:npl=100,format=gbrpf32le,zscale=p=bt709,tonemap=tonemap=hable:desat=0,zscale=t=bt709:m=bt709:r=tv,format=yuv420p10le -c:v libx265 -crf 20 -r:v 30 -an -preset superfast -tune fastdecode "$NAME".{SDR.x265.10b}.{no.audio}.mkv

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
	echo "If a script takes MORE than 120 seconds to complete it will ask you to"
	echo "press ENTER to terminate."
	echo
	echo "If a script takes LESS than 120 seconds to complete it will auto"
	echo "terminate after 10 seconds"
echo -------------------------========================-------------------------
## Exit, wait or auto-quit.
if [ $(( SECONDS - start )) -gt 120 ]
	then
	echo "Script takes more than 120 seconds to complete."
	echo Press ENTER key to exit !
	echo -------------------------========================-------------------------
	read name
	exit
fi
	echo "Script takes less than 120 seconds to complete."
	echo "Auto-quit in 10 sec. (You can press X)"
	echo -------------------------========================-------------------------
	sleep 10
	exit
## -----===== End of bash =====-----
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
## -----===== End of file =====-----
