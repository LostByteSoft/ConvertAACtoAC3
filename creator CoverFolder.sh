#!/bin/bash
#!/usr/bin/ffmpeg
start=$SECONDS
now=$(date +"%Y-%m-%d_%A_%I:%M:%S")
echo "Current time : $now"
echo --- Start of bash ---
sleep 0.5				# Leave time to windows to reseize.
printf '\033[8;25;100t'		# will resize the window

echo -----------------------------------------------------------------------------
echo "LostByteSoft, no CopyRight or CopyLeft"
echo
echo "You specify ONE image file and this convert to THREE files."
echo "Convert ONE image file to 1000 x 1000 px poster.jpg"
echo "Convert ONE image file to 1000 x 1000 px nameofthefolder.jpg"
echo "Convert ONE image file to 500 x 500 px cover.jpg"
echo "Create files for music album or movie folder"
echo "By LostByteSoft"
echo "Version 2021-12-15"
echo "Bash only"

echo -----------------------------------------------------------------------------
echo "Verify if imagemagick is installed."
echo "sudo apt-get install imagemagick."

gnudate() {
    if hash imagemagick 2>/dev/null; then
        imagemagick "$@"
    else
        date "$@"
    fi
}

echo -----------------------------------------------------------------------------
echo "Select filename using dialog."

FILE="$(zenity --file-selection --filename=$HOME/$USER --title="Select a File, Convert ONE image file to 1000 x 1000 px")"
	echo "Your file is $FILE"
	export VAR1="$FILE"
	echo dirname = "$(dirname "${VAR1}")"
	echo basename = "$(basename "${VAR1}")"
	echo FILE = "$FILE"

echo -----------------------------------------------------------------------------
echo "Verify if variable exist."
if test -z "$FILE"
	then
		echo "Variable\$FILE is empty and now exit. You don't have selected a file."
		echo Press ENTER to continue.
		read name
		exit
	else
		echo "\$FILE is NOT empty."
		echo "You have selected "$FILE""
fi

echo -----------------------------------------------------------------------------

echo "Get the last Folder"
INPUT="$(dirname "${VAR1}")"
echo ${INPUT##*/}                

echo "Copy and convert files."
echo cp
echo cp "$FILE" """$(dirname "${VAR1}")""/Folder.jpg"
echo cp "$FILE" """$(dirname "${VAR1}")""/Cover.jpg"
echo cp "$FILE" """$(dirname "${VAR1}")""/${INPUT##*/}".jpg
cp "$FILE" """$(dirname "${VAR1}")""/Folder.jpg"
cp "$FILE" """$(dirname "${VAR1}")""/Cover.jpg"
cp "$FILE" """$(dirname "${VAR1}")""/${INPUT##*/}".jpg

echo mogrify
echo mogrify -resize 1000x1000 """$(dirname "${VAR1}")""/Folder.jpg"
echo mogrify -resize 500x500 """$(dirname "${VAR1}")""/Cover.jpg"
echo mogrify -resize 500x500 """$(dirname "${VAR1}")""/${INPUT##*/}.jpg"
mogrify -resize 1000x1000 """$(dirname "${VAR1}")""/Folder.jpg"
mogrify -resize 500x500 """$(dirname "${VAR1}")""/Cover.jpg"
mogrify -resize 1000x1000 """$(dirname "${VAR1}")""/${INPUT##*/}.jpg"

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
