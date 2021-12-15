#!/bin/bash
start=$SECONDS
printf '\033[8;25;100t'		# will resize the window

echo --- Start of file ---
echo -----------------------------------------------------------------------------

	echo "Auto create m3u playlist for folders (with autoname)"
	echo "By LostByteSoft"
	echo "Version 2021-12-14 Original release"
	echo "Version 2021-12-15 folder select"
	
	echo "--- Read me ---"
	echo "Select a MUSIC MP3 folder and create m3u for this folder."
	echo "Will take the folder name for the *.m3u name"
	
echo -----------------------------------------------------------------------------
	echo "Select folder"
		
	way="$(zenity --file-selection --title="Choose a directory of mp3 files" --filename=$HOME/$USER --directory)"

echo -----------------------------------------------------------------------------
	echo "Directory and file name"
	
	export VAR1="$way"
	echo way = "$way"
	echo dirname = "$(dirname "${VAR1}")"
	echo basename = "$(basename "${VAR1}")"

echo -----------------------------------------------------------------------------
	echo "Create m3u list, Mp3 in direct folder, with name"
	echo
	echo "Temp File location"
	echo "/dev/shm/m3u.tmp"
	
	find "$way" -type f -iname "*.mp3" > /dev/shm/m3u.tmp
	#find "$way" -type f -iname "*.mp3" > "$way"/"$(basename "${VAR1}")".m3u""
	
	echo
	echo "Files found"
	input="/dev/shm/m3u.tmp"
	while IFS= read -r line
	do
	echo "$line"
	done < "$input"
	sleep 1
	
	#work# sed -e 's!/home/master/Desktop/OST Christine 1983/!!' /dev/shm/m3u.tmp > "$way"/"$(basename "${VAR1}")".m3u""
	#NOT work# sed e 's!"$way"/!!' "/dev/shm/m3u.tmp" > "$way"/"$(basename "${VAR1}")".m3u""
	
	## work with bizzare empty var
	## remove the path inside the file
	new=
	sed "s|$way|$new|g" "/dev/shm/m3u.tmp" > "$way"/"$(basename "${VAR1}")".m3u""
	
	echo
	echo "Final Playlist"
	input="$way"/"$(basename "${VAR1}")".m3u""
	while IFS= read -r line
	do
	echo "$line"
	done < "$input"
	sleep 1
	
	echo
	echo "Final File location"
	echo "$way"/"$(basename "${VAR1}")".m3u""

echo -----------------------------------------------------------------------------

	echo Finish... This script take $(( SECONDS - start )) seconds to complete
	echo Press ENTER key to exit !
	read name

echo --- End of bash ---
