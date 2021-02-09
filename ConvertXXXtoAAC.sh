#!/bin/bash
# /usr/bin/ffmpeg
# -----------------------------------------------------------------------------

echo "Convert ONE FILE to audio AAC"
echo "By LostByteSoft"
echo "Version 2021-01-22"
echo "Use ffmpeg only"

# -----------------------------------------------------------------------------

echo "Select filename using dialog"
FILE="$(zenity --file-selection --title="Select a File")"
;echo "Your file is $FILE"

# -----------------------------------------------------------------------------

if test -z "$FILE"
then
      echo "\$FILE is empty and now exit"
      read -n 1 -s -r -p "Press any key to continue"
      exit
else
      echo "\$FILE is NOT empty it contain $FILE"
fi

# -----------------------------------------------------------------------------

VAR="$FILE"
echo "${VAR}"

ffmpeg -i "$FILE" -c:s copy -c:v copy -c:a aac "${VAR}".aac

;echo "Input file name was "$FILE""
;echo "Output file name is "$HOME"/Desktop/"${VAR}".aac"
exit

# --- end of file --------------------------------------------------------------------------
