#!/bin/bash
# /usr/bin/ffmpeg
# -----------------------------------------------------------------------------

echo "Turn a video 90 deg"
echo "By LostByteSoft"
echo "Version 2021-01-22"
echo "Use ffmpeg only"

# -----------------------------------------------------------------------------

ffmpeg -i dancing.mp4 -vf "transpose=2" dancing-out.mp4
exit

# --- end of file --------------------------------------------------------------------------
