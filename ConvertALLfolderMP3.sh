#!/bin/bash
# /usr/bin/ffmpeg
# -----------------------------------------------------------------------------

echo "Convert ALL audio/video file in folder to audio mp3"
echo "By LostByteSoft"
echo "Version 2021-01-22"
echo "Use ffmpeg only"

# -----------------------------------------------------------------------------

for i in *.*;
  do name=`echo "$i" | cut -d'.' -f1`
  echo "$name"
  ffmpeg -i "$i" "${name}.mp3"
done

# --- end of file --------------------------------------------------------------------------
