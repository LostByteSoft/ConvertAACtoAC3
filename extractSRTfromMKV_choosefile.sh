echo --- Start of file ---
#!/bin/bash
echo -----------------------------------------------------------------------------
echo "Extract subtitles from MKV file MKV IDX SUB for a specified file"
echo "By LostByteSoft"
echo "Version 2021-02-16"
echo "https://askubuntu.com/questions/452268/extract-subtitle-from-mkv-files"
echo "Author: https://askubuntu.com/users/230052/nux"
echo -----------------------------------------------------------------------------

DIR="$(zenity --file-selection --filename=$HOME/$USER --file-filter=*.mkv --title="Select a file (*.mkv)")"

	echo "Please wait..."
	#echo DIR = "$DIR"
	#echo Press ENTER to continue.
	#read name

# -----------------------------------------------------------------------------

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
    `mkvextract tracks "$filename" $tracknumber:"$subtitlename.srt" > /dev/null 2>&1`
    `chmod g+rw "$subtitlename.srt"`
  done
done

# -----------------------------------------------------------------------------
exit
# --- End of file ---
