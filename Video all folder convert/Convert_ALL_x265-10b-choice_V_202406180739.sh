#!/bin/bash
#!/usr/bin/ffmpeg
	start=$SECONDS
	now=$(date +"%Y-%m-%d_%A_%H:%M:%S")
	me=$(basename "$0")
	
echo -------------------------===== Start of bash ====-------------------------
	printf '\033[8;40;100t'		# will resize the window, if needed.
	#printf '\033[8;40;115t'	# will resize the window, if needed.
	#printf '\033[8;40;130t'	# will resize the window, if needed.

	red=`tput setaf 1`
	green=`tput setaf 2`
	yellow=`tput setaf 11`
	blue=`tput setaf 12`
	orange=`tput setaf sgr9`
	reset=`tput sgr0`

	## General purposes variables. Watch before program to specific variables.
	## All variables must be 0 or 1
	debug=0		## test debug. (0 or 1 debug mode)
	error=0		## test error. (0 or 1 make error)
	noquit=0	## noquit option. (0 or 1)
	automatic=0	## automatic without (at least minimal) dialog box.

	## Auto-generated variables. Don't change theses variables.
	random=$(shuf -i 4096-131072 -n 1)	## Used for temp folders. A big number hard to guess for security reasons.
	part=0					## don't change this value. (0)
	random2=$RANDOM				## Normal random
	primeerror=0				## ending error detector

	echo
	echo "Software lead-in. LostByteSoft ; https://github.com/LostByteSoft"
	echo
	echo "NEVER remove dual ## in front of lines. Theses are code annotations."
	echo "You can test / remove single # for testing purpose."
	echo
	echo "Current time : $now"
	echo
	echo "Common variables, you can changes theses variables as you wish to test."
	echo "Debug data : debug=$debug error=$error part=$part noquit=$noquit random=$random random2=$random2 primeerror=$primeerror"
	me="$(basename "$(test -L "$0" && readlink "$0" || echo "$0")")"
	echo
	echo "Running job file :"
	echo
	echo $(dirname "$0")/$me
	echo

part=$((part+1))
echo "-------------------------===== Section $part =====-------------------------"
echo Specific softwares variables, you can change theses variables.
	echo
	echo noquit=0 , 0 or 1 , 0 deactivated , 1 activated
	noquit=1
	echo
## Software name, what is this, version, informations.
	echo "What it does ?"
	echo "Convert ONE file to audio/video"
	echo
	echo "This is a SIMPLE file conversion"
	echo
	echo "Read me for this file (and known bugs) :"
	echo
	echo "This software use theses softwares:"
	echo
	echo "Use ffmpeg https://ffmpeg.org/ffmpeg.html"
	echo "Use Gnu Parallel https://www.gnu.org/software/parallel/"
	echo
	echo "Options https://trac.ffmpeg.org/wiki/Encode/H.264"
	echo "4k demo HDR https://www.demolandia.net"
	echo
	echo "Informations : (EULA at the end of file, open in text.)"
	echo "By LostByteSoft, no copyright or copyleft. https://github.com/LostByteSoft"
	echo
	echo "Don't hack paid software, free software exists and does the job better."
	echo

echo -------------------------========================-------------------------
	echo Version compiled on : Also serves as a version
	echo 2024-06-18_Tuesday_07:39:02
echo -------------------------========================-------------------------
echo "Color codes / Informations."
	echo
	echo  "${green}	████████████████     ALL OK / ACTIVE      ████████████████ ${reset}"
	echo   "${blue}	████████████████      INFORMATION(S)      ████████████████ ${reset}"
	echo "${yellow}	████████████████   ATTENTION / INACTIVE   ████████████████ ${reset}"
	echo    "${red}	████████████████   FATAL ERROR / OFFLINE  ████████████████ ${reset}"
	echo

echo -------------------------========================-------------------------
echo "Functions codes and color"
	echo
	echo 	"Function ${blue}█████${reset} Debug. Activate via source program debug=1."

	debug() {
		echo
		echo "Debug data : debug=$debug error=$error part=$part noquit=$noquit random=$random random2=$random2 automatic=$automatic primeerror=$primeerror"
		echo
		}

	if [ "$debug" -eq "1" ]; then
		echo
		echo "${blue}██████████████████████████████ DEBUG ACTIVATED AT START ███████████████████████████${reset}"
		echo
		fi

	echo 	"Function ${red}█████${reset} Error detector. Errorlevel show error msg."

	error()
	if [ "$?" -ge 1 ]; then
		noquit=1
		primeerror=$((primeerror+1))
		error=1
		echo
		echo "${red}█████████████████████████████████ ERROR $part █████████████████████████████████${reset}"
		echo
		echo "Debug data : debug=$debug error=$error part=$part noquit=$noquit random=$random random2=$random2 automatic=$automatic primeerror=$primeerror"
		echo
		echo "!!! ERROR was detected !!! Press ANY key to try to CONTINUE !!!"
		echo
		read -n 1 -s -r -p "Press any key to CONTINUE"
		echo
		fi

	if [ "$automatic" -eq "1" ]; then
		echo
		echo "${green}███████████████████████████ AUTOMATIC ACTIVATED ████████████████████████${reset}"
		echo
		fi

echo
part=$((part+1))
echo "-------------------------===== Section $part =====-------------------------"
## Simple function bar to TimeOut 12 sec.
	## Version 2.01

	functionfastbar() {
		if [ "$debug" -eq 0 ]; then
			echo -ne ${blue}'	TimeOut |                        |    (0%)\r'${reset}
			sleep 0.7
			echo -ne ${blue}'	TimeOut |  █                     |   (5%)\r'${reset}
			sleep 0.7
			echo -ne ${blue}'	TimeOut |  ██                    |   (10%)\r'${reset}
			sleep 0.7
			echo -ne ${blue}'	TimeOut |  ███                   |   (15%)\r'${reset}
			sleep 0.6
			echo -ne ${blue}'	TimeOut |  ████                  |   (20%)\r'${reset}
			sleep 0.6
			echo -ne ${blue}'	TimeOut |  █████                 |   (25%)\r'${reset}
			sleep 0.6
			echo -ne ${blue}'	TimeOut |  ██████                |   (30%)\r'${reset}
			sleep 0.6
			echo -ne ${blue}'	TimeOut |  ███████               |   (35%)\r'${reset}
			sleep 0.6
			echo -ne ${blue}'	TimeOut |  ████████              |   (40%)\r'${reset}
			sleep 0.6
			echo -ne ${blue}'	TimeOut |  █████████             |   (45%)\r'${reset}
			sleep 0.6
			echo -ne ${blue}'	TimeOut |  ██████████            |   (50%)\r'${reset}
			sleep 0.6
			echo -ne ${blue}'	TimeOut |  ███████████           |   (55%)\r'${reset}
			sleep 0.6
			echo -ne ${blue}'	TimeOut |  ████████████          |   (60%)\r'${reset}
			sleep 0.6
			echo -ne ${blue}'	TimeOut |  █████████████         |   (65%)\r'${reset}
			sleep 0.6
			echo -ne ${blue}'	TimeOut |  ██████████████        |   (70%)\r'${reset}
			sleep 0.6
			echo -ne ${blue}'	TimeOut |  ███████████████       |   (75%)\r'${reset}
			sleep 0.6
			echo -ne ${blue}'	TimeOut |  ████████████████      |   (80%)\r'${reset}
			sleep 0.6
			echo -ne ${blue}'	TimeOut |  █████████████████     |   (85%)\r'${reset}
			sleep 0.6
			echo -ne ${blue}'	TimeOut |  ██████████████████    |   (90%)\r'${reset}
			sleep 0.6
			echo -ne ${blue}'	TimeOut |  ███████████████████   |   (95%)\r'${reset}
			sleep 0.6
			echo -ne ${blue}'	TimeOut |  ████████████████████  |  (100%)\r'${reset}
			sleep 0.1
			echo -ne '\n'
		else
			echo ${blue} ████████████████████ DEBUG BYPASS functionfastbar ████████████████████${reset}
			sleep 1
		fi
		}
## Simple function small bar to wait 3 sec.
	## Version 1.03
	## Part of code came from here https://github.com/rabb1t/spinners , Created by Pavel Raykov aka 'rabbit' / 2018-11-08 (c)

	functionsmallbar()
		{
		if [ "$debug" -eq 0 ]; then
			#echo
			width=40
			perc=0
			speed="0.1" # seconds
			inc="$(echo "100/${width}" | bc -ql)"
			#echo -n "	Wake Up.. 0% "
			echo -n "	Wait... "

			while [ $width -ge 0 ]; do
				printf "\e[0;93;103m%s\e[0m %.0f%%" "0" "${perc}"
				sleep $speed
				let width--
				perc="$(echo "${perc}+${inc}" | bc -ql)"
		
				if [ ${perc%%.*} -lt 10 ]; then
					printf "\b\b\b"
				else
					printf "\b\b\b\b"
				fi
			done
			echo
		else
			echo ${blue} ████████████████████ DEBUG BYPASS ALL BARS ████████████████████${reset}
		fi
		}

## -------------------------========================-------------------------
	echo Check installed requirements !
	echo
if command -v ffmpeg >/dev/null 2>&1
	then
		echo "Ffmpeg installed continue."
		dpkg -s ffmpeg | grep Version
		echo "${green} ████████████████ OK ████████████████ ${reset}"
		echo
	else
		echo "You don't have ' ffmpeg ' installed, now exit in 10 seconds."
		echo "Add with : sudo apt-get install ffmpeg"
		echo
		echo "${red}████████████████ Dependency error ████████████████${reset}"
		echo
		read -n 1 -s -r -p "Press ENTER key to continue anyway (NOT a good idea) !"
		echo
	fi

echo -------------------------========================-------------------------
echo "All lowercase for convert... (NOT activated, remove both # to activate)"
	echo
	## This line put all lowercase FROM selected folder to the files names.
	#echo "cd "$file" && find . -name '*.*' -exec sh -c ' a=$(echo "$0" | sed -r "s/([^.]*)\$/\L\1/"); [ "$a" != "$0" ] && mv "$0" "$a" ' {} \;"
	#cd "$file" && find . -name '*.*' -exec sh -c ' a=$(echo "$0" | sed -r "s/([^.]*)\$/\L\1/"); [ "$a" != "$0" ] && mv "$0" "$a" ' {} \;

echo -------------------------========================-------------------------
echo "Names not supported / Informations."
	echo
	echo "${blue}	████████████████████████████████████████████████████████████████${reset}"
	echo "		!!! NAMES starting with symbols are NOT SUPPORTED !!!"
	echo "${blue}	████████████████████████████████████████████████████████████████${reset}"
	echo

echo -------------------------========================-------------------------
echo "Select folder or filename using dialog !"
	echo

	#file="$(zenity --file-selection --filename=$HOME/ --title="Select a file, all format supported")"			## File select.
	file=$(zenity --file-selection --filename=$HOME/ --title="Choose a directory to convert all file" --directory)	## Directory select.
	## file="/$HOME/Pictures/"
	## file="/$HOME/Downloads/"
	## --file-filter="*.jpg *.gif"
	## --file-filter='*[WwEeBbPp] | *[JjPpGg]' 

	count=`ls -1 "$file" 2>/dev/null | wc -l`
	echo Count : $count
	echo "You have selected :"
	echo "$file"
	echo

### file or folder
	if test -z "$file"	## for cancel on zenity
		then
			echo "You click CANCEL !"
			echo
			echo -------------------------========================-------------------------
			echo
			echo "${yellow}█████████████████████ NO DATA TO PROCESS █████████████████████${reset}"
			echo
			read -n 1 -s -r -p "Press any key to EXIT"
			echo
			exit
		fi

	if [ "$count" -eq 0 ]	## for n files in directory
		then
			echo "You don't have selected a folder including files !"
			echo
			echo -------------------------========================-------------------------
			echo
			echo "${yellow}█████████████████████ NO DATA TO PROCESS █████████████████████${reset}"
			echo
			read -n 1 -s -r -p "Press any key to EXIT"
			echo
			exit
		fi

echo -------------------------========================-------------------------
echo "Number of jobs processed concurrently at the same time ? (Refer as parallel CPU cores)"
	echo

	cpu=$(nproc)
	defx=$(( cpu / 2 ))	## for audio files
	defv=$(( cpu / 4 ))	## for video files
	defi=$(( cpu * 2 ))	## for images files
	defy=$(( cpu * 4 ))	## for images files
	defz=$(( cpu * 8 ))	## for images files

	## Put an # in front of "entry" to do an automatic choice.

	entry=$(zenity --scale --value="1" --min-value="1" --max-value="$defx" --title "Convert files with Multi Cores Cpu" --text "How many cores do you want to use ? You have "$cpu" total cores !\n\n\tDefault suggested value is 1 for video.\n\n\tDefault suggested value is "$defv" for audio.\n\n\tDefault suggested value is "$defi" for images.\n\n(1 to whatever core you want to use will work anyway !)")

if test -z "$entry"
	then
		echo "Default value of "$cpu" (Safe value) will be used. Now continue."
		entry=1
		echo "You have selected : $entry"
	else
		echo "You have selected : $entry"
	fi

if [ "$entry" -ge $defi ]; then
	echo
	echo "${yellow}█████████████████████████ WARNING █████████████████████████${reset}"
	echo
	echo "!!! You have chosen a very high parallel work value, this may slow down the calculation rather than speed it up !!!"
	echo
	read -n 1 -s -r -p "Press any key to CONTINUE"
	echo
	fi
	
echo -------------------------========================-------------------------
## Input_Directory_Output
	echo "Input name, directory and output name : (Debug helper)"
	echo

## Set working path.
	BASEDIR=$(dirname "$0")
	echo Basedir : "$BASEDIR"
	dir=$(pwd)

## file or folder selected
	echo "Working dir : "$dir""
	echo Input file : "$file"
	export VAR="$file"
	echo

## directory section
	INPUT="$(dirname "${VAR}")"	
	echo "Get the last Folder : ${INPUT##*/}"
	echo Base directory : "$(dirname "${VAR}")"
	echo Base name: "$(basename "${VAR}")"
	echo

## Output file name
	name=`echo "$file" | rev | cut -f 2- -d '.' | rev` ## remove extension
	echo "Output name ext : "$name""
	name1=`echo "$(basename "${VAR}")" | rev | cut -f 2- -d '.' | rev` ## remove extension
	echo "Output name bis : "$name1""
	echo

## Debug data
	echo "Debug data : autoquit=$autoquit debug=$debug error=$error part=$part noquit=$noquit random=$random"
	echo

echo -------------------------========================-------------------------

	## local var
	runningjob=0
	#debug=1
	
	if [ -f /dev/shm/job.lock ]; then
		echo
		echo "${red} █████████ Lock-up already exist. Waiting for job finish. █████████ ${reset}"
		echo
		fi

function_zenitywait () {
	(
	echo "10" ; sleep 1
	echo "20" ; sleep 1
	echo "30" ; sleep 1
	echo "40" ; sleep 1
	echo "50" ; sleep 1
	echo "60" ; sleep 1
	echo "70" ; sleep 1
	echo "80" ; sleep 1
	echo "90" ; sleep 1
	echo "100" ; sleep 1
	) |
	zenity --progress --width 400 --height 150 --title="Checker ; Lock-up already exist." \
	--text="\nWaiting for job finish... or press Cancel to remove lock-up.\n\n" --timeout 10

	if [ $? -eq 1 ] ; then
		rm "/dev/shm/job.lock" 2> /dev/null
		runningjob=1
		fi

	}	## End function function_zenitywait

	while [ -f /dev/shm/job.lock ]	## Watch if file exist
		do
		#echo "Debug : If file exist goto loop checker !"
		function_zenitywait
		done
	
	if [ runningjob -eq 1 ] ; then
		touch /dev/shm/job.lock
		runningjob=0
		fi
	
	choice=$?

part=$((part+1))
echo "-------------------------===== Section $part =====-------------------------"

	echo
	if [ ! -f /dev/shm/job.lock ]; then
		echo "${blue} █████████ A lock up will be created, prevent running multiples SSH jobs. █████████ ${reset}"
		echo
		## Create a file to lock up!
		touch /dev/shm/job.lock
		runningjob=0
		fi


	if [ "$debug" -eq 1 ]; then
		echo
		debug
		echo
		echo "Debug Unlock job"
		echo
		echo Debug job lock : choice = $choice runningjob = $runningjob
		echo
		read -n 1 -s -r -p "Press ENTER key to continue !"
		echo
		fi

part=$((part+1))
echo "-------------------------===== Section $part =====-------------------------"

echo Finding files...

	rm "/dev/shm/findvideo.txt" 2> /dev/null

	## Easy way to add a file format, copy paste a new line.
	echo "Will NOT find files in sub folders...."
	#find $file -iname '*.*'  >> "/dev/shm/findvideo.txt"
	find "$file" -maxdepth 1 -iname '*.MP4'  >> "/dev/shm/findvideo.txt"
	find "$file" -maxdepth 1 -iname '*.MKV'  >> "/dev/shm/findvideo.txt"
	find "$file" -maxdepth 1 -iname '*.WEBM'  >> "/dev/shm/findvideo.txt"
	find "$file" -maxdepth 1 -iname '*.AVI'  >> "/dev/shm/findvideo.txt"

	lines=$(wc -l < "/dev/shm/findvideo.txt")

	if [ "$lines" -eq "0" ]; then
		echo "You don't have selected a folder with files, now exit in 3 seconds."
		part=$((part+1))
		echo "-------------------------===== Section $part =====-------------------------"
		sleep 3
		exit
	fi

	echo Finding finish.
	echo

	echo List finding files:
	cat "/dev/shm/findvideo.txt"
	echo

	echo Finding finish, with file count : $lines
	echo

part=$((part+1))
echo "-------------------------===== Section $part =====-------------------------"

	## Local var
	aac=0
	ac3=0
	dts=0
	mp3=0
	copy=0
	none=0

	response=$(zenity --height=250 --width=300 --list --radiolist --text "Select sound output option" --column "Select" \
	--column "Sound_Type" FALSE "AAC" FALSE "MP3" FALSE "AC3" TRUE "DTS" FALSE "Copy" FALSE "None")

		if [ -z "$response" ] ; then
			echo
			read -n 1 -s -r -p "You press cancel. Press ENTER key to exit !"
			echo
			exit
		fi
			echo
			IFS=":" ; for word in $response ; do 
				case $word in
				AAC) aac=1 ;;
				MP3) mp3=1 ;;
				AC3) ac3=1 ;;
				DTS) dts=1 ;;
				Copy) copy=1 ;;
				None) none=1 ;;
				esac
			done
	
	echo Debug data : aac=$aac mp3=$mp3 ac3=$ac3 dts=$dts copy=$copy none=$none entry=$entry
	echo

	if [ $aac -eq 1 ]; then
	## x265 10b aac
	parallel -a "/dev/shm/findvideo.txt" -j $entry ffmpeg -loglevel error -v error -stats -i \
	{} -vf format=yuv420p10le -c:v libx265 -crf 21 -preset faster -tune fastdecode -c:a aac {.}.{SDR-x265-10b}.{aac}.mkv
	error $?
	fi
	
	if [ $mp3 -eq 1 ]; then
	## x265 10b mp3
	parallel -a "/dev/shm/findvideo.txt" -j $entry ffmpeg -loglevel error -v error -stats -i \
	{} -vf format=yuv420p10le -c:v libx265 -crf 21 -preset faster -tune fastdecode -c:a mp3 {.}.{SDR-x265-10b}.{mp3}.mkv
	error $?
	fi
	
	if [ $ac3 -eq 1 ]; then	
	## x265 10b ac3
	parallel -a "/dev/shm/findvideo.txt" -j $entry ffmpeg -loglevel error -v error -stats -i \
	{} -vf format=yuv420p10le -c:v libx265 -crf 21 -preset faster -tune fastdecode -c:a ac3 {.}.{SDR-x265-10b}.{ac3}.mkv
	error $?
	fi
	
	if [ $dts -eq 1 ]; then	
	## x265 10b dts
	parallel -a "/dev/shm/findvideo.txt" -j $entry ffmpeg -loglevel error -v error -stats -i \
	{} -vf format=yuv420p10le -c:v libx265 -crf 21 -preset faster -tune fastdecode -strict experimental -c:a dts {.}.{SDR-x265-10b}.{dts}.mkv
	error $?
	fi
	
	if [ $copy -eq 1 ]; then
	## x265 10b copy
	parallel -a "/dev/shm/findvideo.txt" -j $entry ffmpeg -loglevel error -v error -stats -i \
	{} -vf format=yuv420p10le -c:v libx265 -crf 21 -preset faster -tune fastdecode -c:a copy {.}.{SDR-x265-10b}.{copy}.mkv
	error $?
	fi
	
	if [ $none -eq 1 ]; then
	## x265 10b none
	parallel -a "/dev/shm/findvideo.txt" -j $entry ffmpeg -loglevel error -v error -stats -i {} \
	-vf format=yuv420p10le -c:v libx265 -crf 21 -preset faster -tune fastdecode -an {.}.{SDR-x265-10b}.{none}.mkv
	error $?
	fi

	echo
	echo $?
	echo

	subfolder=converted
	converted=*}.mkv

part=$((part+1))
echo "-------------------------===== Section $part =====-------------------------"
echo "Move files to new folder ?"
	echo
	## Variable
	echo Files to move :
	echo ""$file"/$converted"
	echo Move to :
	echo ""$file"/"$subfolder""
	echo
	
	while true;do functionfastbar ; done &
	if zenity --question --timeout 12 --question --text="Do you want to move files to (Suggest yes) :\n\n ""$file"/"$subfolder"" ?"
	kill $!; trap 'kill $!' SIGTERM
		then
			echo
			echo Create folder...
				echo
				echo mkdir -p """$file""/"$subfolder""
				mkdir -p """$file""/"$subfolder""
				## YES all of these fu**** QUOTES are required !!
		
			echo Move files...
				echo
				echo ""$file"/$converted" ""$file"/"$subfolder""/
				mv ""$file"/"$converted"" ""$file"/"$subfolder""/
				## YES all of these fu**** QUOTES are required !!
				echo

		else
			echo "Files not moved."	
		fi

	echo "Don't forget to move associated files! (*.srt *.jpg *.m3u etc)"
	echo

part=$((part+1))
echo "-------------------------===== Section $part =====-------------------------"
echo "Delete temp files :"
	echo
	echo  "rm /dev/shm/findvideo.txt 2> /dev/null"
	rm "/dev/shm/findvideo.txt" 2> /dev/null 2> /dev/null
	echo

part=$((part+1))
echo "-------------------------===== Section $part =====-------------------------"
echo "Unlock ssh nodes."
	echo

	if [ "$runningjob" -eq 0 ]; then
		rm "/dev/shm/job.lock" 2> /dev/null
		echo "${green} █████████ Cluster released, new jobs available. █████████ ${reset}"
		echo
	else
		echo "${blue} █████████ Had work in calculation and will not be unlocked. █████████ ${reset}"
		echo
		fi

part=$((part+1))
echo "-------------------------===== Section $part =====-------------------------"
echo "Software lead out."
	echo
	echo "Debug data : debug=$debug error=$error part=$part noquit=$noquit random=$random random2=$random2 primeerror=$primeerror"
	echo
	echo "Finish... with numbers of actions : $part"
	echo "This script take $(( SECONDS - start )) seconds to complete."
	date=$(date -d@$(( SECONDS - start )) -u +%H:%M:%S)
	echo "Time needed: $date"
	now=$(date +"%Y-%m-%d_%A_%I:%M:%S")
	echo "Current time : $now"
	echo
	echo "$date $now $me" >>/dev/shm/logs.txt
	echo "	Debug data : debug=$debug error=$error part=$part noquit=$noquit random=$random random2=$random2 automatic=$automatic primeerror=$primeerror" >>/dev/shm/logs.txt
	echo "	File (If present) : $file" >>/dev/shm/logs.txt
	echo " " >>/dev/shm/logs.txt

echo -------------------------===== End of Bash ======-------------------------
## Exit, wait or auto-quit.

	if [ "$primeerror" -ge "1" ]; then
		echo
		echo "	${red}████████████████████████████████████████████${reset}"
		echo "	${red}██                                        ██${reset}"
		echo "	${red}██           ERROR ERROR ERROR            ██${reset}"
		echo "	${red}██                                        ██${reset}"
		echo "	${red}████████████████████████████████████████████${reset}"
		echo
		echo "Numbers of error(s) : $primeerror"
		echo
		functionsmallbar
		echo
		read -n 1 -s -r -p "Press ENTER key to Continue !"
		echo
	else
		echo
		echo "	${green}████████████████████████████████████████${reset}	${blue}████████████████████████████████████████${reset}"
		echo "	${green}██                                    ██${reset}	${blue}██                                    ██${reset}"
		echo "	${green}██         NO errors detected.        ██${reset}	${blue}██       Time needed : $date       ██${reset}"
		echo "	${green}██                                    ██${reset}	${blue}██                                    ██${reset}"
		echo "	${green}████████████████████████████████████████${reset}	${blue}████████████████████████████████████████${reset}"
		echo
	fi

	if [ "$noquit" -eq "1" ]; then
		echo
		echo "${blue}	█████████████████ NO exit activated ███████████████████${reset}"
		echo
		read -n 1 -s -r -p "Press ENTER key to exit !"
		echo
		exit
		fi

	if [ "$debug" -eq "1" ]; then
		debug
		echo "${blue}		█████ DEBUG WAIT | Program finish. █████${reset}"
		echo
		read -n 1 -s -r -p "Press ENTER key to continue !"
		echo
		fi

	echo
	echo "${green}	███████████████ Finish, quit in 3 seconds █████████████████${reset}"
	sleep 0.5
	echo
	functionsmallbar
	echo
	sleep 1
	exit

## -----===== Start of eula =====-----

	End-user license agreement (eula)

 	JUST DO WHAT THE F*** YOU WANT WITH THE PUBLIC LICENSE
 	
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
 	
 	YOU MUST ACCEPT THESES TERMS OR NOTHING WILL HAPPEN.
 	
 	LostByteSoft no copyright or copyleft we are in the center.
 	
 	You can send your request and your Christmas wishes to this address:
 	
 		Père Noël
 		Pôle Nord, Canada
 		H0H 0H0

## -----===== End of file =====-----