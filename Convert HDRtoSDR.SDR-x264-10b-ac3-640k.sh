#!/bin/bash
#!/usr/bin/ffmpeg
## -----===== Start of bash =====-----
	#printf '\033[8;40;80t'		# will resize the window, if needed.
	printf '\033[8;40;125t'	# will resize the window, if needed.
	#printf '\033[8;50;200t'	# will resize the window, if needed.
	sleep 0.50
	
echo -------------------------========================-------------------------
## Software lead-in
	start=$SECONDS
	now=$(date +"%Y-%m-%d_%A_%I:%M:%S")
	echo "Current time : $now"
	red=`tput setaf 1`
	green=`tput setaf 2`
	yellow=`tput setaf 11`
	blue=`tput setaf 12`
	reset=`tput sgr0`
## COmmon variables, you can changes theses variables as you wish to test (0 or 1)
	autoquit=0	# autoquit anyway to script takes more than 2 min to complete
	debug=0		# test debug
	error=0		# test error
	part=0		# don't change this value

echo -------------------------========================-------------------------

	echo Version compiled on : Also serves as a version
	echo 2022-02-25_Friday_12:35:10
	echo
## Software name, what is this, version, informations.
	echo "Software name: Convert HDRtoSDR-SDR-x264-10b-ac3-48000hz-640k"
	echo
	echo What it does ?
	echo "Convert ONE video file HDR to SDR Convert HDRtoSDR-SDR-x264-10b-ac3-48000hz-640k"
	echo
	echo "Read me for this file (and known bugs) :"
	echo
	echo "Use 7z https://www.7-zip.org/download.html"
	echo "Use https://imagemagick.org/index.php"
	echo "Use Gnu Parallel https://www.gnu.org/software/parallel/"
	echo "Use ffmpeg https://ffmpeg.org/ffmpeg.html"
	echo
	echo "Options https://trac.ffmpeg.org/wiki/Encode/H.264"
	echo "4k demo HDR https://www.demolandia.net"
	echo
	echo "Informations : (EULA at the end of file, open in text.)"
	echo "By LostByteSoft, no copyright or copyleft. https://github.com/LostByteSoft"
	echo
	echo "Don't hack paid software, free software exists and does the job better."
echo -------------------------========================-------------------------

echo "Check installed requirement !"

if command -v ffmpeg >/dev/null 2>&1
	then
		echo "Ffmpeg installed continue."
	else
		echo "You don't have ' ffmpeg ' installed, now exit in 10 seconds."
		echo "Add with : sudo apt-get install ffmpeg"
		echo -------------------------========================-------------------------
		sleep 10
		exit
fi
echo -------------------------========================-------------------------
echo Function Debug. Activate via source program debug=1.

debug()
if [ "$debug" -ge 1 ]; then
		echo
		echo "${yellow}██████████████████████████████ DEBUG SLEEP ███████████████████████████████${reset}"
		echo
		echo debug = $debug 	part = $part 	input = $input
		echo cpu = $cpu 	defv = $defv 	defa = $defa
		echo defi = $defi 	entry = $entry 	autoquit = $autoquit
		echo 
		read -n 1 -s -r -p "Press any key to EXIT"
		exit
		fi

echo Function Error detector. If errorlevel is 1 or greater will show error msg.
	error()
	if [ "$?" -ge 1 ]; then
		part=$((part+1))
		echo
		echo "${red}█████████████████████████████████ ERROR $part █████████████████████████████████${reset}"
		echo
		echo "!!! ERROR was detected !!! Press ANY key to try to CONTINUE !!! Will probably exit !!!"
		echo
		read -n 1 -s -r -p "Press any key to CONTINUE"
		echo
		fi

echo Function Auto Quit. If autoquit=1 will automaticly quit.
	if [ "$autoquit" -eq "1" ]; then
		echo
		echo "${blue}████████████████████████████ AUTO QUIT ACTIVATED █████████████████████████${reset}"
		echo
		fi

echo -------------------------========================-------------------------
echo "Select filename using dialog !"

	file="$(zenity --file-selection --filename=$HOME/$USER --title="Select a file, all format supported")"
	#file=$(zenity  --file-selection --filename=$HOME/$USER --title="Choose a directory to convert all file" --directory)
	## --file-filter="*.jpg *.gif"

if test -z "$file"
	then
		echo "You don't have selected a file, now exit in 3 seconds."
		echo -------------------------========================-------------------------
		sleep 3
		exit
	else
		echo "You have selected :"
		echo "$file"
fi
echo -------------------------========================-------------------------
echo "Input name, directory and output name : (Debug helper)"
## Set working path.
	dir=$(pwd)
	echo "Working dir : "$dir""
	echo Input file : "$file"
	export VAR="$file"
	echo
	echo Base directory : "$(dirname "${VAR}")"
	echo Base name: "$(basename "${VAR}")"
	echo
## Output file name
	name=`echo "$file" | rev | cut -f 2- -d '.' | rev` ## remove extension
	echo "Output name ext : "$name""
	name1=`echo "$(basename "${VAR}")" | rev | cut -f 2- -d '.' | rev` ## remove extension
	echo "Output name bis : "$name1""
	
echo -------------------------========================-------------------------
## Variables, for program."
	part=0

## The code program.
	part=$((part+1))
	echo "-------------------------===== Section $part =====-------------------------"
echo "ffmpeg conversion"

### debug pixel info
### ffmpeg -h encoder=libx265 | grep pixel

### x264 8b preset

### good quality (Low) (x264 8bit)
### ffmpeg -i "$file" -vf zscale=t=linear:npl=100,format=gbrpf32le,zscale=p=bt709,tonemap=tonemap=hable:desat=0,zscale=t=bt709:m=bt709:r=tv,format=yuv420p -c:v libx264 -crf 25 -r:v 30 -an -preset superfast -tune fastdecode -max_muxing_queue_size 1024 "$NAME".{SDR.x264.8b}.{no.audio}.mkv

### compromis x264 (normal pc will do the job) (Medium) (x264 8bit)
### ffmpeg -i "$file" -vf zscale=t=linear:npl=100,format=gbrpf32le,zscale=p=bt709,tonemap=tonemap=hable:desat=0,zscale=t=bt709:m=bt709:r=tv,format=yuv420p -c:v libx264 -crf 20 -r:v 30 -an -preset superfast -tune fastdecode "$NAME".{SDR.x264.8b}.{no.audio}.mkv

###Better quality and x264 (Need a bigger PC) (medium) {SDR.x264.10b}"
ffmpeg -i "$file" -vf zscale=t=linear:npl=100,format=gbrpf32le,zscale=p=bt709,tonemap=tonemap=hable:desat=0,zscale=t=bt709:m=bt709:r=tv,format=yuv420p10le -c:v libx264 -crf 20 -preset faster -tune fastdecode -c:a ac3 -ar 48000 -b:a 640k "$name".{BluRay-2160p-5.1}.{SDR-x264-10b}.{ac3}.mkv

### x265 10b presets

### better quality and x265 (Need a bigger PC) (Hi) (x265 10bit)
### ffmpeg -i "$file" -vf zscale=t=linear:npl=100,format=gbrpf32le,zscale=p=bt709,tonemap=tonemap=hable:desat=0,zscale=t=bt709:m=bt709:r=tv,format=yuv420p10le -c:v libx265 -crf 20 -r:v 30 -an -preset superfast -tune fastdecode "$NAME".{SDR.x265.10b}.{no.audio}.mkv

## -preset ultrafast
## -preset medium

	error $?
	
echo -------------------------========================-------------------------
## Exit, wait or auto-quit.
if [ "$autoquit" -eq "1" ]
then
		echo "Script will auto quit in 1 seconds."
		echo
		echo "${blue}██████████████████████████████ Finish Now ████████████████████████████████${reset}"
		echo
		sleep 1
	else
	{
	if [ $(( SECONDS - start )) -gt 120 ]
		then
			echo "Script takes more than 120 seconds to complete."
			echo "Press ENTER key to exit !"
			echo
			echo "${yellow}████████████████████████████████ Finish ██████████████████████████████████${reset}"
			read name
		else
			echo "Script takes less than 120 seconds to complete."
			echo "Auto-quit in 10 sec. (You can press X)"
			echo
			echo "${green}████████████████████████████████ Finish ██████████████████████████████████${reset}"
			sleep 10
		fi
	}
	fi

	exit

## -----===== End of bash =====-----

End-user license agreement (eula)

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
