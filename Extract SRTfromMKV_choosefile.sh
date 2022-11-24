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
	echo "Software name: extract SRTfromMKV_choosefile"
	echo
	echo What it does ?
	echo "Extract subtitles from MKV file MKV IDX SUB for a specified file"
	echo
	echo Informations :
	echo "By LostByteSoft, no copyright or copyleft"
	echo "https://github.com/LostByteSoft"
	echo "https://askubuntu.com/questions/452268/extract-subtitle-from-mkv-files"
	echo "Author: https://askubuntu.com/users/230052/nux"
	echo
	echo "Don't hack paid software, free software exists and does the job better."
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

#DIR="$(zenity --file-selection --filename=$HOME/$USER --file-filter=*.mkv --title="Select a file *.mkv")"
DIR="$(zenity --file-selection --filename=$HOME/$USER --title="Select a file *.*")"

echo -----------------------------------------------------------------------------

if test -z "$DIR"
	then
		echo "\$DIR is empty and now exit. You don't have selected a file."
		echo Press ENTER to continue.
		read name
		exit
	else
		echo "\$DIR is NOT empty."
		echo "You have selected "$DIR""
fi

echo -----------------------------------------------------------------------------

	echo "Please wait..."
	#echo DIR = "$DIR"
	#echo Press ENTER to continue.
	#read name

echo -----------------------------------------------------------------------------

# Get all the MKV files in this dir and its subdirs
find "$DIR" -type f -name '*.m2ts' | while read filename
do
  # Find out which tracks contain the subtitles
  mkvmerge -i "$filename" | grep 'subtitles' | while read subline
  do
    # Grep the number of the subtitle track
    tracknumber=`echo $subline | egrep -o "[0-9]{1,2}" | head -1`

    # Get base name for subtitle
    subtitlename=${filename%.*}

    # Extract the track to a .tmp file
    `mkvextract tracks "$filename" $tracknumber:"$subtitlename.srt" > /dev/null 2>&1`
    `chmod g+rw "$subtitlename.srt"`
  done
done

## Error detector.
if [ "$?" -ge 1 ]; then
	echo "!!! ERROR was detected !!! Press ENTER key to terminate !!!"
	echo
	echo "${red}ERROR ███████████████████████████ ERROR █████████████████████████████ ERROR ${reset}"
	read name
	exit
fi
	
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

