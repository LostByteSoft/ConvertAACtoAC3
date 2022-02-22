#!/bin/bash
#!/usr/bin/ffmpeg
## -----===== Start of bash =====-----
	#printf '\033[8;30;80t'		# will resize the window, if needed.
	#printf '\033[8;40;80t'		# will resize the window, if needed.
	printf '\033[8;40;90t'	# will resize the window, if needed.
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
	reset=`tput sgr0`

echo -------------------------========================-------------------------
	echo Version compiled on : Also serves as a version
	echo 2022-02-18_Friday_02:15:25
	echo
## Software name, what is this, version, informations.
	echo "Software name: Creator Cover Folder Name"
	echo "File name: Creator CoverFolderName.sh"
	echo
	echo What it does ?
	echo "You specify ONE image file and this convert to THREE files."
	echo
	echo "Read me for this file (and known bugs) :"
	echo
	echo "Create images files for music cover, album cover and movie poster."
	echo
	echo "Convert ONE image file to 1000 x 1000 px, poster.jpg"
	echo "Convert ONE image file to 750 x 750 px, nameofthefolder.jpg"
	echo "Convert ONE image file to 500 x 500 px, cover.jpg"
	echo "Bash and imagemagick only"
	echo
	echo "Informations : (EULA at the end of file, open in text.)"
	echo "By LostByteSoft, no copyright or copyleft."
	echo "https://github.com/LostByteSoft"
	echo
	echo "Don't hack paid software, free software exists and does the job better."
echo -------------------------========================-------------------------
echo Function Debug. Activate via source program debug=1.
	debug()
	if [ "$debug" -ge 1 ]; then
		echo
		echo "${yellow}DEBUG SLEEP ████████████████████ DEBUG SLEEP ████████████████████ DEBUG SLEEP${reset}"
		echo
		read -n 1 -s -r -p "Press any key to EXIT"
		exit
	fi

echo Function Error detector. If errorlevel is 1 or greater will show error msg.
	error()
	if [ "$?" -ge 1 ]; then
		echo
		echo "${red}ERROR █████████████████████████████ ERROR █████████████████████████████ ERROR ${reset}"
		echo
		echo "!!! ERROR was detected !!! Press ANY key to try to CONTINUE !!! Will probably exit !!!"
		echo
		echo "This script take $(( SECONDS - start )) seconds to complete."
		date=$(date -d@$(( SECONDS - start )) -u +%H:%M:%S)
		echo "Time needed: $date"
		echo
		read -n 1 -s -r -p "Press any key to continue"
		echo
	fi

echo -------------------------========================-------------------------
echo "Check installed requirements !"

if command -v imagemagick >/dev/null 2>&1
	then
		echo "You don't have ' imagemagick ' installed, now exit in 10 seconds."
		echo "Add with : sudo apt-get install imagemagick"
		echo -------------------------========================-------------------------
		sleep 10
		exit
	else
		echo "imagemagick installed continue."
		dpkg -s imagemagick | grep Version
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
	debug=0
echo "Get the last Folder :"
	INPUT="$(dirname "${VAR}")"
	echo ${INPUT##*/} 
## The code program.

	part=$((part+1))
	echo "-------------------------===== Section $part =====-------------------------"
	echo "Copy and convert files."
	echo cp "$file" """$(dirname "${VAR}")""/Folder.jpg"
	echo cp "$file" """$(dirname "${VAR}")""/Cover.jpg"
	echo cp "$file" """$(dirname "${VAR}")""/${INPUT##*/}".jpg
	cp "$file" """$(dirname "${VAR}")""/Folder.jpg"
	cp "$file" """$(dirname "${VAR}")""/Cover.jpg"
	cp "$file" """$(dirname "${VAR}")""/${INPUT##*/}".jpg
	error $?

	part=$((part+1))
	echo "-------------------------===== Section $part =====-------------------------"
	echo "Copy and convert files."
	echo mogrify -resize 1000x1000 """$(dirname "${VAR}")""/Folder.jpg"
	echo mogrify -resize 500x500 """$(dirname "${VAR}")""/Cover.jpg"
	echo mogrify -resize 750x750 """$(dirname "${VAR}")""/${INPUT##*/}.jpg"
	mogrify -resize 1000x1000 """$(dirname "${VAR}")""/Folder.jpg"
	mogrify -resize 500x500 """$(dirname "${VAR}")""/Cover.jpg"
	mogrify -resize 750x750 """$(dirname "${VAR}")""/${INPUT##*/}.jpg"
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
