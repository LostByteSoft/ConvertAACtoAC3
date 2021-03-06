#!/bin/bash
#!/usr/bin/ffmpeg
# -----------------------------------------------------------------------------

echo "Convert ONE FILE to audio AC3"
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

ffmpeg -i "$FILE" -c:s copy -c:v copy -c:a ac3 "$FILE".ac3

# -----------------------------------------------------------------------------
sleep 3
exit
# --- End of file ---
