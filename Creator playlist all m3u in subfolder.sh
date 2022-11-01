#!/bin/bash
#!/usr/bin/ffmpeg
## -----===== Start of bash =====-----
	#printf '\033[8;40;80t'		# will resize the window, if needed.
	printf '\033[8;40;125t'		# will resize the window, if needed.
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

## Common variables, you can changes theses variables as you wish to test (0 or 1)
	autoquit=0	# autoquit anyway to script takes more than 2 min to complete
	debug=1		# test debug
	error=0		# test error
	part=0		# don't change this value
	
	echo autoquit=$autoquit debug=$debug error=$error

echo -------------------------========================-------------------------
	echo Version compiled on : Also serves as a version
	echo 2022-10-21_Friday_10:44:57
	echo
## Software name, what is this, version, informations.
echo -------------------------========================-------------------------
## Software name, what is this, version, informations.
	echo "Software name: creator playlist all m3u in subfolder"
	echo
	echo What it does ?
	echo "creator playlist all m3u in subfolder"
	echo
	echo Informations :
	echo "By LostByteSoft, no copyright or copyleft"
	echo "https://github.com/LostByteSoft"
	echo "bash script to create playlist files in music subdirectories"
	echo "Steve Carlson (stevengcarlson@gmail.com)"
	echo
	echo "Don't hack paid software, free software exists and does the job better."
echo -------------------------========================-------------------------
echo Function Debug. Activate via source program debug=1.
debug()
	if [ "$debug" -ge 1 ]; then
		echo
		echo "${yellow}█████████████████████████████████ DEBUG ██████████████████████████████████${reset}"
		echo
		echo debug = $debug 	part = $part 	file = $file
		echo cpu = $cpu 	defv = $defv 	defa = $defa
		echo defi = $defi 	entry = $entry 	autoquit = $autoquit
		echo 
		read -n 1 -s -r -p "Press any key to continue"
		#exit
	fi
	
		if [ "$debug" -eq "1" ]; then
		echo
		echo "${yellow}██████████████████████████████ DEBUG ACTIVATED ███████████████████████████${reset}"
		echo
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

	#file="$(zenity --file-selection --filename=$HOME/$USER --title="Select a file, all format supported")"
	subdir=$(zenity  --file-selection --filename=$HOME/$USER --title="Choose a directory to convert all file" --directory)
	## --file-filter="*.jpg *.gif"

if test -z "$subdir"
	then
		echo "You don't have selected a file, now exit in 3 seconds."
		echo -------------------------========================-------------------------
		sleep 3
		exit
	else
		echo "You have selected :"
		echo "$subdir"
fi
echo -------------------------========================-------------------------
echo "Input name, directory and output name : (Debug helper)"
## Set working path.
	dir=$(pwd)
## file or folder selected
	echo "Working dir : "$dir""
	echo Input file : "$file"
	export VAR="$file"
	echo
## directory section
	INPUT="$(dirname "${VAR}")"	
	echo "Get the last Folder : ${INPUT##*/}"
	echo Base directory : "$(dirname "${VAR}")"
	echo Base name: "$(basename "${VAR}")"
	echo
## Output file name
	name=`echo "$file" | rev | cut -f 2- -d '.' | rev` ## remove extension
	echo "Output name ext : "$name""
	name1=`echo "$(basename "${VAR}")" | rev | cut -f 2- -d '.' | rev` ## remove extension
	echo "Output name bis : "$name1""
	
echo -------------------------========================-------------------------

	part=$((part+1))
	echo "-------------------------===== Section $part =====-------------------------"

	echo "Will create a m3u file for each sub folder."
	echo "Will NOT create an m3u file in the folder you have seleced."

	part=$((part+1))
	echo "-------------------------===== Section $part =====-------------------------"

find . -type d |
while read subdir
do
  #rm -f "$subdir"/*.m3u

	echo "$subdir"/*""
  for filename in "$subdir"/*""
  do
    if [ ${filename: -4} == ".mp3" ] || [ ${filename: -5} == ".flac" ] || [ ${filename: -5} == ".loss" ] || [ ${filename: -5} == ".aiff" ] || [ ${filename: -4} == ".aif" ]
    then
	echo "${filename##*/}"
	echo "${filename##*/}" >> ./"$subdir"/"${subdir##*/}.m3u"
    fi
  done

done

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
	echo "If a script takes MORE than 120 seconds to complete it will ask"
	echo "you to press ENTER to terminate."
	echo
	echo "If a script takes LESS than 120 seconds to complete it will auto"
	echo "terminate after 10 seconds"
	echo

echo -------------------------========================-------------------------
## Exit, wait or auto-quit.
	echo
	echo Processing file of "$subdir" finish !
	echo
	debug $?

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
			echo
			echo "${yellow}████████████████████████████████ Finish ██████████████████████████████████${reset}"
			echo
			echo -------------------------========================-------------------------
			read -n 1 -s -r -p "Press ENTER key to exit !"
		else
			echo "Script takes less than 120 seconds to complete."
			echo
			echo "${green}████████████████████████████████ Finish ██████████████████████████████████${reset}"
			echo
			echo -------------------------========================-------------------------
			echo "Auto-quit in 10 sec. (You can press X)"
			sleep 10
		fi
	}
	fi

	exit

## -----===== End of bash =====-----

	End-user license agreement (eula)

 	JUST DO WHAT THE F*** YOU WANT WITH THE PUBLIC LICENSE
 	
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
 	
 	YOU MUST ACCEPT THESES TERMS OR NOTHING WILL HAPPEN.
 	
 	LostByteSoft no copyright or copyleft we are in the center.

## -----===== End of file =====-----
