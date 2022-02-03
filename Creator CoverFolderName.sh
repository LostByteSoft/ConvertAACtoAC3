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
	echo "Software name: Creator CoverFolderName.sh"
	echo What it does ?
	echo "You specify ONE image file and this convert to THREE files."
	echo Informations :
	echo "By LostByteSoft, no copyright or copyleft"
	echo "https://github.com/LostByteSoft"
	echo
	echo "Create files for music cover album or movie poster folder"
	echo "Convert ONE image file to 1000 x 1000 px, poster.jpg"
	echo "Convert ONE image file to 750 x 750 px, nameofthefolder.jpg"
	echo "Convert ONE image file to 500 x 500 px, cover.jpg"
	echo "Bash and imagemagick only"
	echo
	echo "Don't hack paid software, free software exists and does the job better."

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
fi
echo -------------------------========================-------------------------
echo "Select filename using dialog !"

	file="$(zenity --file-selection --filename=$HOME/$USER --title="Select a file, all format supported")"
	#file=$(zenity  --file-selection --filename=$HOME/$USER --title="Choose a directory to convert all file" --directory)
	## --file-filter="*.jpg *.gif"

if test -z "$file"
	then
		echo "You don't have selected a file, now exit in 10 seconds."
		echo -------------------------========================-------------------------
		sleep 10
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
	echo "Output file : "$name""
	
	echo "Get the last Folder :"
	INPUT="$(dirname "${VAR}")"
	echo ${INPUT##*/} 

echo -------------------------========================-------------------------
## Variables, for program.
	part=0

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

	part=$((part+1))
	echo "-------------------------===== Section $part =====-------------------------"
	echo "Copy and convert files."
	echo mogrify -resize 1000x1000 """$(dirname "${VAR}")""/Folder.jpg"
	echo mogrify -resize 500x500 """$(dirname "${VAR}")""/Cover.jpg"
	echo mogrify -resize 750x750 """$(dirname "${VAR}")""/${INPUT##*/}.jpg"
	mogrify -resize 1000x1000 """$(dirname "${VAR}")""/Folder.jpg"
	mogrify -resize 500x500 """$(dirname "${VAR}")""/Cover.jpg"
	mogrify -resize 750x750 """$(dirname "${VAR}")""/${INPUT##*/}.jpg"

## Error detector.
if [ "$?" -ge 1 ]; then
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
