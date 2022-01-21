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

	echo "Convert ALLfolderMP3 128"
echo -------------------------========================-------------------------

	echo What it does ?
	echo "Convert ALL audio/video file in folder to audio mp3"
echo -------------------------========================-------------------------

	echo Informations :
	echo "By LostByteSoft, no copyright or copyleft"
	echo "https://github.com/LostByteSoft"
	echo "Use ffmpeg only"
	
echo -------------------------========================-------------------------
echo Version compiled on:
echo 2022-01-20_Thursday_01:33:25
echo -------------------------========================-------------------------

echo You must put this file in the same directory of the file you want to extract !
echo Be careful it will extract ALL video MKV file in the directory.
echo Press ENTER to continue.
read name

for i in *.*;
  do name=`echo "$i" | cut -d'.' -f1`
  echo "$name"
  ffmpeg -i "$i" "${name}.mp3"
done

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
