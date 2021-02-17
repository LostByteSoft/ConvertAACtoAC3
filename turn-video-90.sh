#!/bin/bash
# /usr/bin/ffmpeg
# -----------------------------------------------------------------------------

echo "Turn a video 90 deg"
echo "By LostByteSoft"
echo "Version 2021-02-16"
echo "Use ffmpeg only"

# -----------------------------------------------------------------------------

echo "Select filename using dialog"
FILE="$(zenity --file-selection --filename=$HOME/$USER --title="Select a File")"

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

# -----------------------------------------------------------------------------

ffmpeg -i "$FILE".mp4 -vf "transpose=2" "$FILE"-OUT.mp4

# -----------------------------------------------------------------------------
exit
# --- End of file ---
