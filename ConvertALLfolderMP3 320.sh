#!/bin/bash
#!/usr/bin/ffmpeg
echo -----------------------------------------------------------------------------

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
  ffmpeg -i "$i" -codec:a libmp3lame -b:a 320k "${name}.mp3"
done

echo -----------------------------------------------------------------------------
sleep 3
exit
# --- End of file ---
