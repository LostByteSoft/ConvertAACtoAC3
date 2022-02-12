#!/bin/bash
#!/usr/bin/ffmpeg
## -----===== Start of bash =====-----
	#printf '\033[8;30;80t'		# will resize the window, if needed.
	printf '\033[8;40;80t'		# will resize the window, if needed.
	#printf '\033[8;40;125t'	# will resize the window, if needed.
	#printf '\033[8;50;200t'	# will resize the window, if needed.
echo -------------------------========================-------------------------
## Software lead-in
	red=`tput setaf 1`
	green=`tput setaf 2`
	yellow=`tput setaf 3`
	reset=`tput sgr0`
	start=$SECONDS
	now=$(date +"%Y-%m-%d_%A_%I:%M:%S")
	echo "Current time : $now"
	echo
	echo Version compiled on : Also serves as a version
	echo 2022-02-03_Thursday_04:43:34
echo -------------------------========================-------------------------
## Software name, what is this, version, informations.
	echo "Software name: Convert MANY files to video Convert ALL folder 720p-x264-8b-30f.aac (parallel)"
	echo
	echo What it does ?
	echo "Convert MANY video file to Convert ALL folder 720p-x264-8b-30f.aac (parallel).sh"
	echo
	echo Informations :
	echo "By LostByteSoft, no copyright or copyleft"
	echo "https://github.com/LostByteSoft"
	echo "Use ffmpeg only"
	echo "https://ffmpeg.org/ffmpeg.html"
	echo
	echo "Don't hack paid software, free software exists and does the job better."
echo -------------------------========================-------------------------
echo "Check installed requirements !"

if command -v ffmpeg >/dev/null 2>&1
	then
		echo "Ffmpeg installed continue."
	else
		echo "You don't have ' parallel ' installed, now exit in 3 seconds."
		echo "Add with : sudo apt-get install ffmpeg"
		echo -------------------------========================-------------------------
		sleep 3
		exit
fi

if command -v parallel >/dev/null 2>&1
	then
		echo "Parallel installed continue."
	else
		echo "You don't have ' parallel ' installed, now exit in 3 seconds."
		echo "Add with : sudo apt-get install parallel"
		echo -------------------------========================-------------------------
		sleep 3
		exit
fi

echo -------------------------========================-------------------------
echo "Enter cores to use ?"
	cpu=$(nproc)
	def=$(( cpu / 2 ))
#entry=$(zenity --entry --width 500 --title "Convert files with Multi Cores Cpu" --text "How many cores do you want to use ? You have $cpu cores !\n\nDefault value is $def\n\n(1 to whatever core you want to use)")

entry=$(zenity --scale --value="$def" --min-value="1" --max-value="$cpu" --title "Convert files with Multi Cores Cpu" --text "How many cores do you want to use ? You have $cpu cores !\n\nDefault value is $def, it is suggested you only use real cores.\n\n(1 to whatever core you want to use)")

if test -z "$entry"
	then
		echo "Default value of $cpu / 2 will be used. Now continue in 3 seconds."
		entry=$(( cpu / 2 ))
		echo "You have selected : $entry"
		sleep 3
	else
		echo "You have selected : $entry"
fi

echo -------------------------========================-------------------------
echo "Select filename using dialog !"

	#file="$(zenity --file-selection --filename=$HOME/$USER --title="Select a file, all format supported")"
	file=$(zenity  --file-selection --filename=$HOME/$USER --title="Choose a directory to convert all file" --directory)
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
	echo Input file : "$file"
	echo "Working dir : "$dir""
	export VAR="$file"
	echo Base directory : "$(dirname "${VAR}")"
	echo Base name: "$(basename "${VAR}")"
## Output file name
	name=`echo "$file" | rev | cut -f 2- -d '.' | rev` ## remove extension
	echo "Output file : "$name""
echo -------------------------========================-------------------------
## Variables, for program."
	part=0

## The code program.
	part=$((part+1))
	echo "-------------------------===== Section $part =====-------------------------"
	parallel -j $entry ffmpeg -i {} -vf scale=1280x720:flags=lanczos,format=yuv420p -c:v libx264 -crf 20 -r:v 30 -c:a aac {.}.720p-x264-8b-30f.aac.mkv ::: "$file"/*.*

## Error detector.
if [ "$?" -ge 1 ]; then
	echo
	echo "!!! ERROR was detected !!! Press ENTER key to terminate !!!"
	echo
	echo "${red}ERROR ███████████████████████████ ERROR █████████████████████████████ ERROR ${reset}"
	read name
	exit
fi
	
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
	echo "If a script takes MORE than 120 seconds to complete it will ask you to"
	echo "press ENTER to terminate."
	echo
	echo "If a script takes LESS than 120 seconds to complete it will auto"
	echo "terminate after 10 seconds"
	echo

## Exit, wait or auto-quit.
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
