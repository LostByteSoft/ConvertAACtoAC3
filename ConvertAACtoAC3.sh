#!/bin/bash
# convertfile.sh - convert the file using dialog box
# Exemples of converting:
# ffmpeg -i input.6ch.aac.mkv -c:s copy -c:v copy -c:a ac3 output.6ch.ac3.mkv
# DTS not working
# ffmpeg -i input.6ch.aac.mkv -c:s copy -c:v copy -strict experimental -c:a dts output.6ch.dts.mkv
# /usr/bin/ffmpeg
# Version 2019-09-29-1658
# -------------------------------------------------
# purpose - convert file
#  $1 - filename 
function convert_file(){
	local f="$1"
	local m="$0: file $f failed to convert."
	if [ -f $f ] 
	then
		/usr/bin/ffmpeg $FILE && m="$0: $f file convertd."
	else
		m="$0: $f is not a file."
	fi 
	dialog --title "convert file" --clear --msgbox "$m" 10 50
}

# select filename using dialog
# store it to $FILE
FILE=$(dialog --title "convert a file" --stdout --title "Please choose a file to convert(Select spacebar)" --fselect "$HOME"/Desktop/ 14 48)

# convert file aac to ac3
# The video was copied the audio was converted.
ffmpeg -i "$FILE" -c:s copy -c:v copy -c:a ac3 "$HOME"/Desktop/output.ac3.mkv

sleep 2
echo "Input file name is "$FILE", output file name is output.ac3.mkv"
echo "Wait 5 seconds and exit."
sleep 5
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
