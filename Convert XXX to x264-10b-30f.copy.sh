#!/bin/bash
#!/usr/bin/ffmpeg
## -----===== Start of bash =====-----
	#printf '\033[8;30;80t'		# will resize the window, if needed.
	#printf '\033[8;40;80t'		# will resize the window, if needed.
	printf '\033[8;40;100t'	# will resize the window, if needed.
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
	echo 2022-02-20_Sunday_07:26:49
	echo
## Software name, what is this, version, informations.
	echo "Software name: Convert XXX to 2160p-x264-10b-30f-copy audio"
	echo "File name : Convert XXX to x264-10b-30f-copy.sh"
	echo
	echo What it does ?
	echo "Convert ONE video file to 2160p-x264-10b-30f-copy upscale or downscale 4k"
	echo
	echo "Read me for this file (and known bugs) :"
	echo
	echo "Informations : (EULA at the end of file, open in text.)"
	echo "Use ffmpeg only"
	echo
	echo "https://ffmpeg.org/ffmpeg.html"
	echo "Options https://trac.ffmpeg.org/wiki/Encode/H.264"
	echo "4k demo HDR https://4kmedia.org/"
	echo
	echo "By LostByteSoft, no copyright or copyleft."
	echo "https://github.com/LostByteSoft"
	echo
	echo "Don't hack paid software, free software exists and does the job better."
echo -------------------------========================-------------------------
echo Function Debug. Activate via source program debug=1.
	debug()
	if [ "$debug" -ge 1 ]; then
		echo
		echo "${yellow}██████████████████████████████ DEBUG SLEEP ███████████████████████████████${reset}"
		echo
		echo debug = $debug
		echo part = $part
		echo INPUT = $INPUT
		echo {INPUT##*/}  = ${INPUT##*/} 
		echo input = $input
		echo cpu = $(nproc)
		echo def = $def
		echo entry = $entry
		echo autoquit = $autoquit
		echo 
		read -n 1 -s -r -p "Press any key to EXIT"
		exit
	fi

echo Function Error detector. If errorlevel is 1 or greater will show error msg.
	error()
	{
	if [ "$?" -ge 1 ]; then
		echo
		echo "${red}█████████████████████████████████ ERROR █████████████████████████████████${reset}"
		echo
		echo "!!! ERROR was detected !!! Press ANY key to try to CONTINUE !!! Will probably exit !!!"
		echo
		read -n 1 -s -r -p "Press any key to CONTINUE"
		echo
	fi
	}

echo -------------------------========================-------------------------
echo "Check installed requirement !"

if command -v ffmpeg >/dev/null 2>&1
	then
		echo "Ffmpeg installed continue."
		dpkg -s ffmpeg | grep Version
	else
		echo "You don't have ' ffmpeg ' installed, now exit in 10 seconds."
		echo "Add with : sudo apt-get install ffmpeg"
		echo -------------------------========================-------------------------
		sleep 10
		exit
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
echo "Get the last Folder :"
	INPUT="$(dirname "${VAR}")"
	echo ${INPUT##*/}

## The code program.
	part=$((part+1))
	echo "-------------------------===== Section $part =====-------------------------"
echo "ffmpeg conversion"

## Ac3 sound
## ffmpeg -i "$file" -vf scale=3840x2160:flags=lanczos,format=yuv420p10le -c:v libx264 -crf 20 -r:v 30 -c:a ac3 -ar 48000 -b:a 640k "$name".{2160p-x264-10b-30f}.{ac3-48000hz-640k}.mkv

## Dts sound
ffmpeg -i "$file" -vf format=yuv420p10le -c:v libx264 -crf 20 -r:v 30 -c:a copy "$name".2160p-x264-10b-30f-copy.mkv

#ffmpeg -i "$file" -vf scale=1920x1080:flags=lanczos -c:v libx264 -crf 20 -r:v 30 -c:a ac3 -ar 48000 -b:a 640k "$name".{2160p-x264-30}.{ac3-48000-640}.mkv

	error $?
	
echo -------------------------========================-------------------------
## Software lead-out.
	echo "Finish... with numbers of actions : $part"
	echo "This script take $(( SECONDS - start )) seconds to complete."
	date=$(date -d@$(( SECONDS - start )) -u +%H:%M:%S)
	echo "Time needed: $date"
	now=$(date +"%Y-%m-%d_%A_%I:%M:%S")
	echo "Current time : $now"

echo -------------------------========================-------------------------
## Press enter or auto-quit here.
	echo "${yellow}If a script takes MORE than 120 seconds to complete it will ask you to take action !${reset}"
	echo "Press ENTER to terminate."
	echo
	echo "${green}If a script takes LESS than 120 seconds to complete it will auto-terminate !${reset}"
	echo "Auto-terminate after 10 seconds"
	echo

echo -------------------------========================-------------------------
## Exit, wait or auto-quit.
	debug $?

if [ "$autoquit" -eq "1" ]
then
	echo "${blue}██████████████████████████████ Finish Now ████████████████████████████████${blue}"
	sleep 2
	exit
	else
	{
	if [ $(( SECONDS - start )) -gt 120 ]
		then
			echo "Script takes more than 120 seconds to complete."
			echo "Press ENTER key to exit !"
			echo
			echo "${yellow}████████████████████████████████ Finish ██████████████████████████████████${reset}"
			read name
			exit
		else
			echo "Script takes less than 120 seconds to complete."
			echo "Auto-quit in 10 sec. (You can press X)"
			echo
			echo "${green}████████████████████████████████ Finish ██████████████████████████████████${reset}"
			sleep 9
			exit
		fi
	}
fi
	sleep 1
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
