#!/bin/bash
#!/usr/bin/ffmpeg
printf '\033[8;50;125t'		# will resize the window
start=$SECONDS
# -----------------------------------------------------------------------------

echo "Convert ONE FILE to audio DTS"
echo "By LostByteSoft"
echo "Version 2021-02-16"
echo "Use ffmpeg only"

# -----------------------------------------------------------------------------

echo "Select filename using dialog"
FILE="$(zenity --file-selection --filename=$HOME/$USER --title="Select a File")"

#echo "Your file is $FILE"

# -----------------------------------------------------------------------------

if test -z "$FILE"
	then
		echo "\$FILE is empty and now exit. You don't have selected a file."
		echo Press ENTER to continue.
		read name
		exit
	else
		echo "\$FILE is NOT empty."
		echo "You have selected "$FILE""
fi

sleep 1

# -----------------------------------------------------------------------------

ffmpeg -i "$FILE" -c:s copy -c:v copy -strict experimental -c:a dts "$FILE".dts

echo -----------------------------------------------------------------------------

	echo Finish... This script take $(( SECONDS - start )) seconds to complete
	echo Press ENTER key to exit !
	read name

echo --- End of bash ---
