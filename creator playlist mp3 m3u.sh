#!/bin/bash
#!/usr/bin/ffmpeg
start=$SECONDS
now=$(date +"%Y-%m-%d_%A_%I:%M:%S")
echo "Current time : $now"
echo --- Start of bash ---
#sleep 0.5			# Leave time to windows to reseize.
printf '\033[8;50;100t'		# will resize the window

echo --- Start of file ---
echo -----------------------------------------------------------------------------

	echo "Auto create m3u playlist for folders (with autoname)"
	echo "By LostByteSoft"
	echo "Version 2021-12-14 Original release"
	echo "Version 2021-12-15 folder select"
	echo "Version 2021-12-16 debug update"
	
	echo "--- Read me ---"
	echo "Select a MUSIC MP3 folder and create m3u for this folder."
	echo "Will take the folder name for the *.m3u name"
	
echo -----------------------------------------------------------------------------
	echo "Select folder"
		
	way="$(zenity --file-selection --title="Choose a directory of mp3 files" --filename=$HOME/$USER --directory)"

if test -z "$way"
	then
		echo "\$WAY is empty and now exit. You don't have selected a folder."
		echo Press ENTER to EXIT.
		read name
		exit
	else
		echo "\$way is NOT empty."
		echo "You have selected "$way""
fi

echo -----------------------------------------------------------------------------
	echo "Directory and file name"
	
	export VAR1="$way"
	echo way = "$way"
	echo dirname = "$(dirname "${VAR1}")"
	echo basename = "$(basename "${VAR1}")"

echo -----------------------------------------------------------------------------
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

echo -----------------------------------------------------------------------------

	echo Finish... This script take $(( SECONDS - start )) seconds to complete.
	date=$(date -d@$(( SECONDS - start )) -u +%H:%M:%S)
	echo "Time needed: $date"
	now=$(date +"%Y-%m-%d_%A_%I:%M:%S")
	echo "Current time : $now"
	echo Press ENTER key to exit !
	read name
	exit

echo --- End of bash ---
