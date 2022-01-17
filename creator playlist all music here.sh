#!/bin/bash

echo --- Start of bash ---

## Software lead in
start=$SECONDS
now=$(date +"%Y-%m-%d_%A_%I:%M:%S")
echo "Current time : $now"

## Set working path.
# mypath=`realpath $0`
# cd `dirname $mypath`
dir=$(pwd)

echo -----------------------------------------------------------------------------
## Reseize windows terminal.
## printf '\033[8;50;100t'			# will resize the window, if needed.
## sleep 0.5				# Leave time to windows to reseize.
echo  -----------------------------------------------------------------------------

	echo "Auto create m3u playlist for folders (with autoname)"
	echo "By LostByteSoft"
	echo "Version 2021-12-14 Original release"
	echo "--- Read me ---"	
	echo "Take the name of previous folder for *.m3u name"
	echo "Will create an *.m3u file for group of *.mp3 in THE DIRECT FOLDER"
	echo "Will do not create for folders or sub folders."
	echo "000 to easy find"

echo -----------------------------------------------------------------------------

	echo "Directory and file name"
	echo "${PWD##*/}"
	echo "Final name will be 000_"${PWD##*/}".m3u"

echo -----------------------------------------------------------------------------

find . -type f \( -name '*.mp3' -o -name '*.flac' -o -name '*.loss' -o -name '*.aiff' -o -name '*.aif' \) -printf "%P\n" > playlist.m3u

echo -----------------------------------------------------------------------------
## Software lead out.

	echo Finish... This script take $(( SECONDS - start )) seconds to complete.
	date=$(date -d@$(( SECONDS - start )) -u +%H:%M:%S)
	echo "Time needed: $date"
	now=$(date +"%Y-%m-%d_%A_%I:%M:%S")
	echo "Current time : $now"
	## Press enter or auto-quit here. Put ## in front of the next 3 lines.
	echo Press ENTER key to exit !
	read name
	exit

echo --- End of bash ---

	echo "Auto-quit in 10 sec."
	sleep 10
	exit
	
echo --- End of bash ---
