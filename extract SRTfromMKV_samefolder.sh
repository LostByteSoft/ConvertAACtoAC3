#!/bin/bash
#!/usr/bin/ffmpeg
start=$SECONDS
now=$(date +"%Y-%m-%d_%A_%I:%M:%S")
echo "Current time : $now"
echo --- Start of bash ---
sleep 0.5				# Leave time to windows to reseize.
printf '\033[8;50;125t'		# will resize the window

echo -----------------------------------------------------------------------------
echo "Extract subtitles from each MKV IDX SUB file in the given directory"
echo "By LostByteSoft"
echo "Version 2021-02-16"
echo "https://askubuntu.com/questions/452268/extract-subtitle-from-mkv-files"
echo "Author: https://askubuntu.com/users/230052/nux"
echo -----------------------------------------------------------------------------

echo You must put this file in the same directory of the file you want to extract !
echo Be careful it will extract ALL video MKV file in the directory.
echo Press ENTER to continue.
read name

# If no directory is given, work in local dir
if [ "$1" = "" ]; then
  DIR="."
else
  DIR="$1"
fi

echo -----------------------------------------------------------------------------

# Get all the MKV files in this dir and its subdirs
find "$DIR" -type f -name '*.mkv' | while read filename
do
  # Find out which tracks contain the subtitles
  mkvmerge -i "$filename" | grep 'subtitles' | while read subline
  do
    # Grep the number of the subtitle track
    tracknumber=`echo $subline | egrep -o "[0-9]{1,2}" | head -1`

    # Get base name for subtitle
    subtitlename=${filename%.*}

    # Extract the track to a .tmp file
    `mkvextract tracks "$filename" $tracknumber:"$subtitlename.srt.tmp" > /dev/null 2>&1`
    `chmod g+rw "$subtitlename.srt.tmp"`
  done
done

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
