#!/bin/bash
#!/usr/bin/ffmpeg
## -----===== Start of bash =====-----
	#printf '\033[8;50;80t'		# will resize the window, if needed.
	printf '\033[8;40;125t'		# will resize the window, if needed.
	sleep 0.50
	## "NEVER remove dual ## in front of lines. Theses are code annotations."
	## "You can test / remove single # for testing purpose."
echo
echo -------------------------========================-------------------------
	start=$SECONDS
	now=$(date +"%Y-%m-%d_%A_%H:%M:%S")
	red=`tput setaf 1`
	green=`tput setaf 2`
	yellow=`tput setaf 11`
	blue=`tput setaf 12`
	reset=`tput sgr0`
	## All variables 0 or 1
	autoquit=0	# autoquit anyway to script takes LESS than 2 min to complete.
	debug=0		# test debug
	error=0		# test error
	part=0		# don't change this value
	noquit=0	# No quit after all operations.
	random=$RANDOM	# Used for temp folders
	echo "Software lead-in. LostByteSoft ; https://github.com/LostByteSoft"
	echo
	echo "Current time : $now"
	echo "Common variables, you can changes theses variables as you wish to test."
	echo
	echo "Debug data : autoquit=$autoquit debug=$debug error=$error part=$part noquit=$noquit random=$random"
echo -------------------------========================-------------------------
	echo Version compiled on : Also serves as a version
	echo 2022-11-23_Wednesday_06:57:45
	echo
## Software name, what is this, version, informations.
	echo "Software name: Creator playlist all music"
	echo "File name : Creator playlist all music select.sh"
	echo
	echo What it does ?
	echo "Auto create m3u playlist for folders (with autoname)"
	echo
	echo "Will create an m3u file in the folder you selected."
	echo "All audio files in sub folders are find and put in file"
	echo "Take the name of previous folder for *.m3u name"
	echo "Will create an *.m3u file for group of *.mp3 in THE DIRECT FOLDER"
	echo "Will do not create for folders or sub folders."
	echo
	echo Informations :
	echo "By LostByteSoft, no copyright or copyleft"
	echo "https://github.com/LostByteSoft"
	echo "Version 2021-12-14 Original release"
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
echo "The code program."

	part=$((part+1))
	echo "-------------------------===== Section $part =====-------------------------"
	echo "Finding files..."
	echo file = "$file"
	echo "(basename "${VAR}")" = "$(basename "${VAR}")"

	#find "$file" . -type f \( -name '*.mp3' -o -name '*.flac' -o -name '*.ac3' -o -name '*.dts' \) -printf "%P\n" > "$file"/"$(basename "${VAR}")".m3u
	find "$file" . -type f \( -name '*.mp3' -o -name '*.flac' -o -name '*.ac3' -o -name '*.dts' \) -printf "%P\n" > "/dev/shm/m3u.tmp"
	error $?

	part=$((part+1))
	echo "-------------------------===== Section $part =====-------------------------"
	echo "Listing..."
	sleep 1
	#cat "$file"/"$(basename "${VAR}")".m3u
	cat "/dev/shm/m3u.tmp"
	error $?
	
	part=$((part+1))
	echo "-------------------------===== Section $part =====-------------------------"
	echo "Name sort (Yes or No (Suggest Yes))"
	if zenity --question --text="Do you want to sort by file name ? (Yes or No (Suggest Yes))"
	then
		part=$((part+1))
		echo "-------------------------===== Section $part =====-------------------------"
		#sort "$file"/"$(basename "${VAR}")".m3u > "$file"/"$(basename "${VAR}")".m3v
		sort "/dev/shm/m3u.tmp" > "/dev/shm/m3u.srt"
		cp "/dev/shm/m3u.srt" "$file"/"$(basename "${VAR}")".m3u
		cat "$file"/"$(basename "${VAR}")".m3u
		echo
		part=$((part+1))
		echo "-------------------------===== Section $part =====-------------------------"
		echo "Files are sorted and m3u is in $file"
	else
		part=$((part+1))
		echo "-------------------------===== Section $part =====-------------------------"
		cp "/dev/shm/m3u.srt" "$file"/"$(basename "${VAR}")".m3u
		cat "$file"/"$(basename "${VAR}")".m3u
		part=$((part+1))
		echo "-------------------------===== Section $part =====-------------------------"
		echo "Files are NOT sorted and m3u is in $file"
	fi
	error $?

echo -------------------------========================-------------------------
## Software lead out
	echo "Finish... with numbers of actions : $part"
	echo "This script take $(( SECONDS - start )) seconds to complete."
	date=$(date -d@$(( SECONDS - start )) -u +%H:%M:%S)
	echo "Time needed: $date"
	now=$(date +"%Y-%m-%d_%A_%I:%M:%S")
	echo "Current time : $now"
	echo
echo -------------------------========================-------------------------
	echo "If a script takes MORE than 120 seconds to complete it will ask"
	echo "you to press ENTER to terminate."
	echo
	echo "If a script takes LESS than 120 seconds to complete it will auto"
	echo "terminate after 10 seconds"
echo -------------------------========================-------------------------
## Exit, wait or auto-quit.
	if [ "$noquit" -eq "1" ]; then
		echo
		echo "${blue}	█████████████████ NO exit activated ███████████████████${reset}"
		echo
		#read -n 1 -s -r -p "Press ENTER key to exit !"
		#exit
		fi

	if [ "$autoquit" -eq "1" ]
		then
			echo
			echo "${green}	███████████████ Finish, quit in 3 seconds █████████████████${reset}"
			echo
			sleep 2
			echo
		else
		{
			if [ "$debug" -eq "1" ]; then
				echo
				echo "${blue}		█████ DEBUG WAIT | Program finish. █████${reset}"
				echo
				echo "Debug data : autoquit=$autoquit debug=$debug error=$error part=$part noquit=$noquit random=$random"
				echo
				read -n 1 -s -r -p "Press ENTER key to continue !"
				echo
			fi
		if [ $(( SECONDS - start )) -gt 120 ]
			then
				echo
				echo "Script takes more than 120 seconds to complete."
				echo
				echo "${blue}	█████████████████████ Finish ███████████████████████${reset}"
				echo
				read -n 1 -s -r -p "Press ENTER key to exit !"
				echo
			else
				echo
				echo "Script takes less than 120 seconds to complete."
				echo
				echo "${green}	█████████████████████ Finish ███████████████████████${reset}"
				echo
				echo "Auto-quit in 5 sec. (You can press X)"
				echo
				sleep 5
				exit
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
 	
 	You can send your request and your Christmas wishes to this address:
 	
 		Père Noël
 		Pôle Nord
 		H0H 0H0
 		Canada

## -----===== End of file =====-----

