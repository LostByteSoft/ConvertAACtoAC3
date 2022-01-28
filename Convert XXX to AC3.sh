#!/bin/bash
#!/usr/bin/ffmpeg
## -----===== Start of bash =====-----
	#printf '\033[8;40;75t'		# will resize the window, if needed.
	printf '\033[8;40;125t'		# will resize the window, if needed.
	#printf '\033[8;50;200t'	# will resize the window, if needed.
echo -------------------------========================-------------------------
## Software lead in
	start=$SECONDS
	now=$(date +"%Y-%m-%d_%A_%I:%M:%S")
	echo "Current time : $now"
	echo
	echo Version compiled on : Also serves as a version
	echo 2022-01-28_Friday_06:54:17
echo -------------------------========================-------------------------
## Software name, what is this, version, informations.
	echo "Convert XXX to AC3"
	echo
	echo What it does ?
	echo "Convert ONE FILE to audio AC3"
	echo
	echo Informations :
	echo "By LostByteSoft, no copyright or copyleft"
	echo "https://github.com/LostByteSoft"
	echo
	echo "Don't hack paid software, free software exists and does the job better."
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

	NAME=`echo "$FILE" | rev | cut -f 2- -d '.' | rev`
	echo "Output file : "$NAME".{ac3-48000hz-640k}.ac3"
	
	echo "Working dir : "$dir""
	export VAR="$FILE"
	echo Base directory : "$(dirname "${VAR}")"
	echo Selected file name: "$(basename "${VAR}")"
	
echo -------------------------========================-------------------------
## The code program.

ffmpeg -i "$FILE" -c:s copy -c:v copy -c:a ac3 -ar 48000 -b:a 640k "$NAME".{ac3-48000hz-640k}.ac3

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
