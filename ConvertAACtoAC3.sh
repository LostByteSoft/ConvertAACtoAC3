#!/bin/bash
# /usr/bin/ffmpeg
# -----------------------------------------------------------------------------

echo "Convert audio/video to audio ac3"
echo "By LostByteSoft"
echo "Version 2019-05-19-10-08"
echo "Use ffmpeg only"
#sleep 1

# -----------------------------------------------------------------------------

echo "Select filename using dialog"
FILE="$(zenity --file-selection --title="Select a File")"
echo "Your file is $FILE"
sleep 1

# -----------------------------------------------------------------------------

if test -z "$FILE"
then
      echo "\$FILE is empty and now exit"
      sleep 1
      read -n 1 -s -r -p "Press any key to continue"
      exit
else
      echo "\$FILE is NOT empty it contain $FILE"
fi
sleep 1

# -----------------------------------------------------------------------------

VAR="$FILE"
echo "${VAR}"
sleep 1
ffmpeg -i "$FILE" -c:s copy -c:v copy -c:a ac3 "${VAR}".ac3

echo "Input file name was "$FILE""
echo "Output file name is "$HOME"/Desktop/"${VAR}".ac3"
sleep 1
exit

;;--- End of bash ---
;
;            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
;   Version 3.14159265358979323846264338327950288419716939937510582
;                          March 2017
;
; Everyone is permitted to copy and distribute verbatim or modified
; copies of this license document, and changing it is allowed as long
; as the name is changed.
;
;            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
;   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
;
;              You just DO WHAT THE FUCK YOU WANT TO.
;
;		     NO FUCKING WARRANTY AT ALL
;
;      The warranty is included in your anus. Look carefully you
;             might miss all theses small characters.
;
;	As is customary and in compliance with current global and
;	interplanetary regulations, the author of these pages disclaims
;	all liability for the consequences of the advice given here,
;	in particular in the event of partial or total destruction of
;	the material, Loss of rights to the manufacturer's warranty,
;	electrocution, drowning, divorce, civil war, the effects of
;	radiation due to atomic fission, unexpected tax recalls or
;	    encounters with extraterrestrial beings 'elsewhere.
;
;      LostByteSoft no copyright or copyleft, we are CopyMiddle.
;
;	If you are unhappy with this software i do not care.
;
;;--- End of file ---
