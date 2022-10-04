#!/bin/bash
#!/usr/bin/ffmpeg
## -----===== Start of bash =====-----
	#printf '\033[8;40;80t'		# will resize the window, if needed.
	printf '\033[8;40;125t'	# will resize the window, if needed.
	#printf '\033[8;50;200t'	# will resize the window, if needed.
	sleep 0.50
	
echo -------------------------========================-------------------------
## Software lead-in
	start=$SECONDS
	now=$(date +"%Y-%m-%d_%A_%I:%M:%S")
	echo "Current time : $now"
	red=`tput setaf 1`
	green=`tput setaf 2`
	yellow=`tput setaf 11`
	blue=`tput setaf 12`
	reset=`tput sgr0`
## COmmon variables, you can changes theses variables as you wish to test (0 or 1)
	autoquit=0	# autoquit anyway to script takes more than 2 min to complete
	debug=0		# test debug
	error=0		# test error
	part=0		# don't change this value

echo -------------------------========================-------------------------

	echo Version compiled on : Also serves as a version
	echo 2022-02-16_Wednesday_11:58:53
	echo
## Software name, what is this, version, informations.
	echo
## Software name, what is this, version, informations.
	echo "Software name: Convert ALL folder files to x264 aac (parallel)"
	echo "File name: Convert ALL folder x264-8b-30f-aac-44100hz-192k (parallel).sh"
	echo
	echo What it does ?
	echo "Convert ONE video file to x264-8b-30f.aac-2.0-44100hz-192k.mkv"
	echo "Perfect format for facebook."
	echo
	echo Informations :
	echo "Use ffmpeg only"
	echo "Informations : (EULA at the end of file, open in text.)"
	echo "By LostByteSoft, no copyright or copyleft."
	echo "https://github.com/LostByteSoft"
	echo
	echo "Don't hack paid software, free software exists and does the job better."
echo -------------------------========================-------------------------
	echo "${red}		███████████████████████████████████████████████${reset}"
	echo "		SPACES ARE NOT SUPPORTED IN PARALLEL CONVERSION"
	echo "${red}		███████████████████████████████████████████████${reset}"
	echo -------------------------========================-------------------------
	#read -n 1 -s -r -p "Press any key to continue"

echo "Check installed requirement !"

if command -v ffmpeg >/dev/null 2>&1
	then
		echo "Ffmpeg installed continue."
	else
		echo "You don't have ' ffmpeg ' installed, now exit in 10 seconds."
		echo "Add with : sudo apt-get install ffmpeg"
		echo -------------------------========================-------------------------
		sleep 10
		exit
fi

if command -v parallel >/dev/null 2>&1
	then
		echo "Parallel installed continue."
		dpkg -s parallel | grep Version
	else
		echo "You don't have ' parallel ' installed, now exit in 10 seconds."
		echo "Add with : sudo apt-get install parallel"
		echo -------------------------========================-------------------------
		sleep 10
		exit
fi

echo -------------------------========================-------------------------
echo Function Debug. Activate via source program debug=1.

debug()
if [ "$debug" -ge 1 ]; then
		echo
		echo "${yellow}██████████████████████████████ DEBUG SLEEP ███████████████████████████████${reset}"
		echo
		echo debug = $debug 	part = $part 	input = $input
		echo cpu = $cpu 	defv = $defv 	defa = $defa
		echo defi = $defi 	entry = $entry 	autoquit = $autoquit
		echo 
		read -n 1 -s -r -p "Press any key to EXIT"
		exit
		fi

echo Function Error detector. If errorlevel is 1 or greater will show error msg.
	error()
	if [ "$?" -ge 1 ]; then
		part=$((part+1))
		echo
		echo "${red}█████████████████████████████████ ERROR $part █████████████████████████████████${reset}"
		echo
		echo "!!! ERROR was detected !!! Press ANY key to try to CONTINUE !!! Will probably exit !!!"
		echo
		read -n 1 -s -r -p "Press any key to CONTINUE"
		echo
		fi

echo Function Auto Quit. If autoquit=1 will automaticly quit.
	if [ "$autoquit" -eq "1" ]; then
		echo
		echo "${blue}████████████████████████████ AUTO QUIT ACTIVATED █████████████████████████${reset}"
		echo
		fi

echo -------------------------========================-------------------------
echo "Numbers of parallel multi-cores to use ?"
	cpu=$(nproc)
	defv=$(( cpu / 4 ))	## for video files
	defa=$(nproc)		## for audio files
	defi=$(( cpu * 2 ))	## for images files
	#echo cpu = $cpu
	#echo defv = $defv
	#echo defa = $defa
	#echo defi = $defi
	entry=$(zenity --scale --value="$defv" --min-value="1" --max-value="32" --title "Convert files with Multi Cores Cpu" --text "How many cores do you want to use ? You have "$cpu" total cores !\n\n\tDefault suggested value is "$defv" for video.\n\n\tDefault suggested value is "$defa" for audio.\n\n\tDefault suggested value is "$defi" for images.\n\n(1 to whatever core you want to use will work anyway !)")

if test -z "$entry"
	then
		echo "Default value of $cpu will be used. Now continue in 3 seconds."
		entry=$(nproc)
		echo "You have selected : $entry"
		#sleep 3
	else
		echo "You have selected : $entry"
fi

echo -------------------------========================-------------------------
echo "Select filename using dialog !"

	#file="$(zenity --file-selection --filename=$HOME/$USER --title="Select a file, all format supported")"
	file=$(zenity  --file-selection --filename=$HOME/$USER --title="Choose a directory to convert all file, will auto select only VIDEO files to convert." --directory)
	## --file-filter="*.jpg *.gif"

if test -z "$file"
	then
		echo "You don't have selected a file, now exit in 3 seconds."
		echo -------------------------========================-------------------------
		sleep 3
		exit
	else
		echo "You have selected :"
		echo "$file"
fi

echo -------------------------========================-------------------------
echo "Input name, directory and output name : (Debug helper)"
## Set working path.
	dir=$(pwd)
	echo "Working dir : "$dir""
	echo Input file : "$file"
	export VAR="$file"
	echo
	echo Base directory : "$(dirname "${VAR}")"
	echo Base name: "$(basename "${VAR}")"
	echo
## Output file name
	name=`echo "$file" | rev | cut -f 2- -d '.' | rev` ## remove extension
	echo "Output name ext : "$name""
	name1=`echo "$(basename "${VAR}")" | rev | cut -f 2- -d '.' | rev` ## remove extension
	echo "Output name bis : "$name1""
	
echo -------------------------========================-------------------------
## Variables, for program."
	part=0
	debug=0
	rm "/dev/shm/findvideo.txt"
## The code program.

## find files
part=$((part+1))
echo "-------------------------===== Section $part =====-------------------------"
echo Finding files...

	## Easy way to add a file format, copy paste a new line.
	echo "Will find files in sub folders too...."
	find $file -name '*.*'  >> "/dev/shm/findvideo.txt"
	#find $file -name '*.mp4'  >> "/dev/shm/findvideo.txt"
	#find $file -name '*.webm'  >> "/dev/shm/findvideo.txt"
	#find $file -name '*.mkv'  >> "/dev/shm/findvideo.txt"
	
	cat "/dev/shm/findvideo.txt"

echo Finding finish.

part=$((part+1))
echo "-------------------------===== Section $part =====-------------------------"
echo Conversion started...

	echo "Parallel convert"

	## parallel -j $entry ffmpeg -i {} -vf format=yuv420p -c:v libx264 -crf 20 -c:a aac -b:a 192k {.}-x264-8b-30f.aac.mkv ::: "$file"/*.*
	
	parallel -j $entry ffmpeg -i {} -vf format=yuv420p10le -c:v libx264 -crf 20 -c:a aac -ac 2 -b:a 192k {.}-x264-10b.aac-44khz-192k.mkv ::: "$file"/*.*
	
	### parallel -j $entry ffmpeg -i {} -vf format=yuv420p10le -c:v libx265 -crf 20 -c:a aac -ac 2 -b:a 192k {.}-x264-10b.aac-44khz-192k.mkv ::: "$file"/*.*
	
	error $?

echo Conversion finish...
echo -------------------------========================-------------------------
## Exit, wait or auto-quit.
if [ "$autoquit" -eq "1" ]
then
		echo "Script will auto quit in 1 seconds."
		echo
		echo "${blue}██████████████████████████████ Finish Now ████████████████████████████████${reset}"
		echo
		sleep 1
	else
	{
	if [ $(( SECONDS - start )) -gt 120 ]
		then
			echo "Script takes more than 120 seconds to complete."
			echo "Press ENTER key to exit !"
			echo
			echo "${yellow}████████████████████████████████ Finish ██████████████████████████████████${reset}"
			read name
		else
			echo "Script takes less than 120 seconds to complete."
			echo "Auto-quit in 10 sec. (You can press X)"
			echo
			echo "${green}████████████████████████████████ Finish ██████████████████████████████████${reset}"
			sleep 10
		fi
	}
	fi

	exit

## -----===== End of bash =====-----

End-user license agreement (eula)

 	JUST DO WHAT YOU WANT WITH THE PUBLIC LICENSE
 	
 	Version 3.1415926532 (January 2022)
 	
 	TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
    	
	Everyone is permitted to copy and distribute verbatim or modified copies of
 	this license document.
 	
 	As is customary and in compliance with current global and interplanetary
 	regulations, the author of these pages disclaims all liability for the
 	consequences of the advice given here, in particular in the event of partial
 	or total destruction of the material, Loss of rights to the manufacturer
 	warranty, electrocution, drowning, divorce, civil war, the effects of radiation
 	due to atomic fission, unexpected tax recalls or encounters with
 	extraterrestrial beings elsewhere.
 	
 	LostByteSoft no copyright or copyleft we are in the center.

## -----===== End of file =====-----
