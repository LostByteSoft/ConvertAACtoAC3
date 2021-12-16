#!/bin/bash
#!/usr/bin/ffmpeg
start=$SECONDS
printf '\033[8;50;125t'		# will resize the window

# -----------------------------------------------------------------------------

echo "Convert ALL audio/video file in folder to audio mp3"
echo "By LostByteSoft"
echo "Version 2021-02-16"
echo "Use ffmpeg only"

echo -----------------------------------------------------------------------------

echo You must put this file in the same directory of the file you want to extract !
echo Be careful it will extract ALL video MKV file in the directory.
echo Press ENTER to continue.
echo -----------------------------------------------------------------------------
read name

for i in *.*;
  do name=`echo "$i" | cut -d'.' -f1`
  echo "$name"
  ffmpeg -i "$i" -c:s copy -c:v copy -c:a ac3 "${name}".ac3
done

echo -----------------------------------------------------------------------------

	echo Finish... This script take $(( SECONDS - start )) seconds to complete
	echo Press ENTER key to exit !
	read name

echo --- End of bash ---
