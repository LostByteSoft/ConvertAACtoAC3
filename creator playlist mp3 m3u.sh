#!/bin/bash
	printf '\033[8;40;100t'			# will resize the window, if needed.
	#printf '\033[8;40;200t'		# will resize the window, if needed.

## -----===== Start of bash =====-----
	## Software lead in
	start=$SECONDS
	now=$(date +"%Y-%m-%d_%A_%I:%M:%S")
	echo "Current time : $now"
	
echo -------------------------========================-------------------------
## Software name, what is this, version, informations.

	echo "creator playlist mp3 m3u"
echo -------------------------========================-------------------------

	echo What it does ?
	echo "Auto create m3u playlist for folders (with autoname)"
echo -------------------------========================-------------------------

	echo Informations :
	echo "By LostByteSoft, no copyright or copyleft"
	echo "https://github.com/LostByteSoft"
		echo "Version 2021-12-14 Original release"
	echo "Version 2021-12-15 folder select"
	echo "Version 2021-12-16 debug update"
	
	echo "--- Read me ---"
	echo "Select a MUSIC MP3 folder and create m3u for this folder."
	echo "Will take the folder name for the *.m3u name"
	
echo -------------------------========================-------------------------
echo Version compiled on:
echo 2022-01-20_Thursday_01:33:25
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

	NAME=`echo "$FILE" | cut -d'.' -f1`
	echo "Output file : "$NAME" (if implemented)"
	
	echo "Working dir : "$dir""
	export VAR="$FILE"
	echo Base directory : "$(dirname "${VAR}")"
	echo Selected file name: "$(basename "${VAR}")"
	
echo -------------------------========================-------------------------
	echo "Create m3u list, Mp3 in direct folder, with name"
	echo "There are a problem if there are many ' . ' in the file name DO NO PUT . (dot) EVERYWHERE"
	echo
	echo "Temp File location:"
	echo "/dev/shm/m3u.tmp"
	echo
	echo "Selected folder:"
	echo "$way"
	
	find "$way" -type f -iname "*.mp3" > "/dev/shm/m3u.tmp"
	#find "$way" -type f -iname "*.mp3" > "/dev/shm/m3u.tmp"
	#find "$way" -type f -iname "*.mp3" > "$way"/"$(basename "${VAR1}")".m3u""
	
	## Need code to sort files in correct number order, not by date created.
	echo
	echo "Files are sorted from "/dev/shm/m3u.tmp" to "/dev/shm/m4u.tmp""
	sort /dev/shm/m3u.tmp > /dev/shm/m4u.tmp
	
	echo
	echo "Mp3 files found (Others format ignored):"
	input1="/dev/shm/m4u.tmp"
	while IFS= read -r line1
	do
	echo "$line1"
	done < "$input1"
	#sleep 1
	
	##work# sed -e 's!/home/master/Desktop/OST/!!' /dev/shm/m3u.tmp > "$way"/"$(basename "${VAR1}")".m3u""
	##NOT work# sed e 's!"$way"/!!' "/dev/shm/m3u.tmp" > "$way"/"$(basename "${VAR1}")".m3u""
		
	## work with bizzare empty var
	## remove the path inside the file and needed an extra
	## These 2 lines write actual mp3 find in the folder you specified.
	new=
	sed "s|$way/|$new|g" "/dev/shm/m4u.tmp" > "$way"/"$(basename "${VAR1}")".m3u""
	
	echo
	echo "Final Playlist:"
	input2="$way"/"$(basename "${VAR1}")".m3u""
	while IFS= read -r line2
	do
	echo "$line2"
	done < "$input2"
	#sleep 1
	
	echo
	echo "Final File location"
	echo "$way"/"$(basename "${VAR1}")".m3u""

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

	### Put ## in front of the next 3 lines if you want to auto-quit.
	echo Press ENTER key to exit !
	read name
	exit
	
	echo "Auto-quit in 5 sec."
	sleep 5
	exit

echo -------------------------========================-------------------------
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

## -----===== End of bash =====-----
