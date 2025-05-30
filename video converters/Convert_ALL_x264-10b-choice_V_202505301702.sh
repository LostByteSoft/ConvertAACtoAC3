#!/bin/bash
#!/usr/bin/ffmpeg

	echo "-------------------------===== Start of bash ====-------------------------"
	printf '\033[8;27;90t'	## minimum of 90 for graphics.
	version=2025-05-30_Friday_17:02:05

	## "0 or 1 , 0 deactivated , 1 activated ## All general variables must be 0 or 1"
		findsubfolders=0
		lowercase=0
		detox=0
		automatic=1
		debug=0
		debugcore=0
		minimize=0
		maximize=0
		reseize=1
		noquit=0

	printf '\033[8;27;90t'	## minimum of 90 for graphics.

##-------------------------=========== SEPARATOR =============-------------------------

	## Lead-in Version 6.05
	echo
	echo
	## Time, host name, file name, pid.
		start=$SECONDS
		now=$(date +"%Y-%m-%d_%A_%H:%M:%S")	## time now
		hostname=$(cat /etc/hostname)
		#hostname="${hostname%-pc}"
		me="$(basename "$(test -L "$0" && readlink "$0" || echo "$0")")"
		id=$(echo $PPID)			## current process id of the bash process
	## General purposes variables. Needed before program to random variables.
		logs=1		## Logging
	## All general variables must be 0, DO NOT CHANGE.
		part=0		## Don't change this value.
		primeerror=0	## Ending error detector, do not change.
		error=0		## Test error, do not change.
	## Auto-generated variables. DO NOT CHANGE.
		random=$(shuf -i 4096-131072 -n 1)	# Used for temp folders. A big number hard to guess for security reasons.
		random2=$RANDOM
	## Colors codes
		red=$(tput setaf 1)
		green=$(tput setaf 2)
		yellow=$(tput setaf 11)
		blue=$(tput setaf 12)
		orange=$(tput setaf 9)
		reset=$(tput sgr0)

##-------------------------=========== SEPARATOR =============-------------------------

	#spd-say "Lost byte soft"

	echo "${green}  ░▒▓█▓▒░      ░▒▓██████▓▒░ ░▒▓███████▓▒░▒▓████████▓▒░ "
	echo "${green}  ░▒▓█▓▒░     ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░         ░▒▓█▓▒░     "
	echo "${green}  ░▒▓█▓▒░     ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░         ░▒▓█▓▒░     "
	echo "${green}  ░▒▓█▓▒░     ░▒▓█▓▒░░▒▓█▓▒░░▒▓██████▓▒░   ░▒▓█▓▒░     "
	echo "${green}  ░▒▓█▓▒░     ░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░  ░▒▓█▓▒░     "
	echo "${green}  ░▒▓█▓▒░     ░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░  ░▒▓█▓▒░     "
	echo "${green}  ░▒▓████████▓▒░▒▓██████▓▒░░▒▓███████▓▒░   ░▒▓█▓▒░     ${reset}"
	echo
	echo "${green}	  ░▒▓███████▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓████████▓▒░▒▓████████▓▒░ "
	echo "${green}	  ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░  ░▒▓█▓▒░   ░▒▓█▓▒░        "
	echo "${green}	  ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░  ░▒▓█▓▒░   ░▒▓█▓▒░        "
	echo "${green}	  ░▒▓███████▓▒░ ░▒▓██████▓▒░   ░▒▓█▓▒░   ░▒▓██████▓▒░   "
	echo "${green}	  ░▒▓█▓▒░░▒▓█▓▒░  ░▒▓█▓▒░      ░▒▓█▓▒░   ░▒▓█▓▒░        "
	echo "${green}	  ░▒▓█▓▒░░▒▓█▓▒░  ░▒▓█▓▒░      ░▒▓█▓▒░   ░▒▓█▓▒░        "
	echo "${green}	  ░▒▓███████▓▒░   ░▒▓█▓▒░      ░▒▓█▓▒░   ░▒▓████████▓▒░ ${reset}"
	echo
	echo "${green}		   ░▒▓███████▓▒░░▒▓██████▓▒░░▒▓████████▓▒░▒▓████████▓▒░ "
	echo "${green}		  ░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░         ░▒▓█▓▒░     "
	echo "${green}		  ░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░         ░▒▓█▓▒░     "
	echo "${green}		   ░▒▓██████▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓██████▓▒░    ░▒▓█▓▒░     "
	echo "${green}			 ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░         ░▒▓█▓▒░     "
	echo "${green}			 ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░         ░▒▓█▓▒░     "
	echo "${green}		  ░▒▓███████▓▒░ ░▒▓██████▓▒░░▒▓█▓▒░         ░▒▓█▓▒░  ${reset}"
	echo
	sleep 1

part=$((part+1))
echo "-------------------------===== Section $part =====-------------------------"
	echo "Software lead-in. LostByteSoft ; https://github.com/LostByteSoft"
	echo
	echo "$me"
	echo
	echo "Version : $version"
	echo
	echo "NEVER remove dual ## in front of lines. Theses are code annotations."
	echo "You can test / remove single # for testing purpose."
	echo
	echo "Current time : $now"
	echo
	echo "You are running this script from : $hostname"
	echo
	echo "Running software file : $(dirname "$0")/"
	echo
	echo "Read me for this file : (EULA at the end of file, open in text.)"
	echo
	echo "By LostByteSoft, no copyright or copyleft. https://github.com/LostByteSoft"
	echo
	echo "Don't hack paid software, free software exists and does the job better."
	echo
	echo "Debug data : debug=$debug error=$error part=$part noquit=$noquit random=$random random2=$random2"
	echo "		primeerror=$primeerror lowercase=$lowercase id=$id reseize=$reseize"
	echo

part=$((part+1))
echo "-------------------------===== Section $part =====-------------------------"
echo "Color codes / Informations."
	echo
	echo  "${green}	████████████████     ALL OK / ACTIVE      ████████████████ ${reset}"
	echo   "${blue}	████████████████      INFORMATION(S)      ████████████████ ${reset}"
	echo "${yellow}	████████████████   ATTENTION / INACTIVE   ████████████████ ${reset}"
	echo    "${red}	████████████████   FATAL ERROR / OFFLINE  ████████████████ ${reset}"
	echo

echo -------------------------========================-------------------------
echo "Functions informations. Version 1,12"
	echo

##-------------------------=========== SEPARATOR =============-------------------------

	name=AUTOMATIC
	explain="The lowest possible questions/pause."
	if [ "$automatic" -eq "0" ]; then
		echo 	"Function ${green}█████${reset} Default deactivated $name . $explain"
	else
		echo 	"Function ${blue}█████${reset} Activated $name . $explain"
	fi
	echo

##-------------------------=========== SEPARATOR =============-------------------------

	name=DEBUG
	explain="Slow down execution with informations."
	if [ "$debug" -eq "0" ]; then
		echo 	"Function ${green}█████${reset} Default deactivated $name . $explain"
	else
		echo 	"Function ${blue}█████${reset} Activated $name . $explain"
	fi
	echo

	debug() {
		echo
		echo "${green}███████████████████████ DEBUG RUNNING ███████████████████████${reset}"
		echo
		echo "Debug data : debug=$debug debugcore=$debugcoreerror=$error part=$part noquit=$noquit automatic=$automatic primeerror=$primeerror"
		echo "		random=$random random2=$random2 id=$id automatic=$automatic reseize=$reseize debugcore=$debugcore"
		echo
		reseize=0
		}

##-------------------------=========== SEPARATOR =============-------------------------

	name=ERROR
	explain="Errorlevel show error messages."
	if [ "$error" -eq "0" ]; then
		echo 	"Function ${green}█████${reset} Default deactivated $name . $explain"
	else
		echo 	"Function ${blue}█████${reset} Activated $name . $explain"
	fi
	echo

	error() {
		if [ "$?" -ge 1 ]; then
			reseize=0
			noquit=1
			automatic=0
			primeerror=$((primeerror+1))
			echo
			echo "${red}█████████████████████████████████ ERROR SECTION $part █████████████████████████████████${reset}"
			debug
			echo "!!! ERROR was detected !!!" ## Press ANY key to try to CONTINUE !!!
			echo
			printf '\033[8;45;90t'		## Will resize the window.
			sleep 1
		else
			echo
			echo "${green} █████████ No error found. █████████ ${reset}"
			echo
			fi
		}

##-------------------------=========== SEPARATOR =============-------------------------

	name=NOQUIT
	explain="Do not quit at the end of the program."
	if [ "$noquit" -eq "0" ]; then
		echo 	"Function ${blue}█████${reset} Default deactivated $name . $explain"
	else
		echo 	"Function ${green}█████${reset} Activated $name . $explain"
	fi
	echo

##-------------------------=========== SEPARATOR =============-------------------------

	name=MINIMIZE
	explain="Minimize the program."
	if [ "$noquit" -eq "0" ]; then
		echo 	"Function ${blue}█████${reset} Default deactivated $name . $explain"
	else
		echo 	"Function ${green}█████${reset} Activated $name . $explain"
	fi

if [ "$minimize" -eq "1" ]; then
	pid=$(echo $PPID)
	if [ "$xdotool" -eq "1" ]; then
			echo "${blue}██████ Minimize activated. ${yellow}pid = $pid${reset} ${blue}██████${reset}"
			sleep 0.2
			window_id=$(xdotool search --pid $pid | tail -1)
			sleep 0.2
			#echo pid = $pid | window_id = $window_id
			xdotool windowminimize "$window_id"
			sleep 0.2
		else
			echo "${yellow}██████ pid = $pid${reset} ${yellow}██████${reset}"
		fi
	fi
	echo

##-------------------------=========== SEPARATOR =============-------------------------

	name=MAXIMIZE
	explain="Minimize the program."
	if [ "$noquit" -eq "0" ]; then
		echo 	"Function ${blue}█████${reset} Default deactivated $name . $explain"
	else
		echo 	"Function ${green}█████${reset} Activated $name . $explain"
	fi

if [ "$maximize" -eq "1" ]; then
	pid=$(echo $PPID)
	if [ "$xdotool" -eq "1" ]; then
			echo "${blue}██████ Minimize activated. ${yellow}pid = $pid${reset} ${blue}██████${reset}"
			sleep 0.2
			window_id=$(xdotool search --pid $pid | tail -1)
			sleep 0.2
			#echo pid = $pid | window_id = $window_id
			xdotool windowmaximize "$window_id"
			sleep 0.2
		else
			echo "${yellow}██████ pid = $pid${reset} ${yellow}██████${reset}"
		fi
	fi
	echo

##-------------------------=========== SEPARATOR =============-------------------------
## Simple function bar to TimeOut 12 sec.
	## Version 2.03
	## https://github.com/LostByteSoft
	## LostBytesSoft, lost byte softwares, because everything is ephemeral.

	functionfastbar() {
		if [ "$debug" -eq 0 ]; then
			echo -ne ${blue}'	TimeOut |                        |    (0%)\r'${reset}
			sleep 1
			echo -ne ${blue}'	TimeOut |  █                     |   (5%)\r'${reset}
			sleep 0.6
			echo -ne ${blue}'	TimeOut |  ██                    |   (10%)\r'${reset}
			sleep 0.6
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
			sleep 0.6
			echo -ne '\n'
		else
			echo ${blue} ████████████████████ DEBUG BYPASS functionfastbar ████████████████████${reset}
			sleep 1
		fi
		}

##-------------------------=========== SEPARATOR =============-------------------------
## Simple function sleep bar to wait. Wait the time you specified in code.
	## Version 1.26
	## https://github.com/LostByteSoft
	## LostBytesSoft, lost byte softwares, because everything is ephemeral.
	## Replace the nothing show sleep with a better looking bar.
	## SPECIFY A SLEEP TIME IN SECONDS BEFORE FUNCTION IN CODE. Default sleep is 3 second if not specified.

	## In code exemple:
	## sleep=3		## Use minimum 1 as a vriable.
	## functionsleepbar

	## Local var.
	sleep=3
	sleep1=0
	sleep2=0

functionsleepbar() {

	if [ "$sleep" -ge "1" ]; then
			sleep1=$(echo "scale=2 ; "$sleep"/20" | bc)
			sleep2=$(echo "scale=2 ; "$sleep"/10" | bc)
		else
			sleep=3
			sleep1=$(echo "scale=2 ; "$sleep"/20" | bc)
			sleep2=$(echo "scale=2 ; "$sleep"/10" | bc)
		fi

	echo -ne ${green}"Sleep time $sleep sec. ${blue}	|	|	|	|	|	|        (0%)\r"${reset}
	sleep "$sleep2"
	echo -ne ${green}"Sleep time $sleep sec. ${blue}	|██	|	|	|	|	|        (5%)\r"${reset}
	sleep "$sleep1"
	echo -ne ${green}"Sleep time $sleep sec. ${blue}	|█████	|	|	|	|	|	(10%)\r"${reset}
	sleep "$sleep1"
	echo -ne ${green}"Sleep time $sleep sec. ${blue}	|███████|	|	|	|	|	(15%)\r"${reset}
	sleep "$sleep1"
	echo -ne ${green}"Sleep time $sleep sec. ${blue}	|███████|█	|	|	|	|	(20%)\r"${reset}
	sleep "$sleep1"
	echo -ne ${green}"Sleep time $sleep sec. ${blue}	|███████|███	|	|	|	|	(25%)\r"${reset}
	sleep "$sleep1"
	echo -ne ${green}"Sleep time $sleep sec. ${blue}	|███████|█████	|	|	|	|	(30%)\r"${reset}
	sleep "$sleep1"
	echo -ne ${green}"Sleep time $sleep sec. ${blue}	|███████|███████|	|	|	|	(35%)\r"${reset}
	sleep "$sleep1"
	echo -ne ${green}"Sleep time $sleep sec. ${blue}	|███████|███████|█	|	|	|	(40%)\r"${reset}
	sleep "$sleep1"
	echo -ne ${green}"Sleep time $sleep sec. ${blue}	|███████|███████|███	|	|	|	(45%)\r"${reset}
	sleep "$sleep1"
	echo -ne ${green}"Sleep time $sleep sec. ${blue}	|███████|███████|█████	|	|	|	(50%)\r"${reset}
	sleep "$sleep1"
	echo -ne ${green}"Sleep time $sleep sec. ${blue}	|███████|███████|███████|	|	|	(55%)\r"${reset}
	sleep "$sleep1"
	echo -ne ${green}"Sleep time $sleep sec. ${blue}	|███████|███████|███████|█	|	|	(60%)\r"${reset}
	sleep "$sleep1"
	echo -ne ${green}"Sleep time $sleep sec. ${blue}	|███████|███████|███████|███	|	|	(65%)\r"${reset}
	sleep "$sleep1"
	echo -ne ${green}"Sleep time $sleep sec. ${blue}	|███████|███████|███████|█████	|	|	(70%)\r"${reset}
	sleep "$sleep1"
	echo -ne ${green}"Sleep time $sleep sec. ${blue}	|███████|███████|███████|███████|	|	(75%)\r"${reset}
	sleep "$sleep1"
	echo -ne ${green}"Sleep time $sleep sec. ${blue}	|███████|███████|███████|███████|█	|	(80%)\r"${reset}
	sleep "$sleep1"
	echo -ne ${green}"Sleep time $sleep sec. ${blue}	|███████|███████|███████|███████|███	|	(90%)\r"${reset}
	sleep "$sleep1"
	echo -ne ${green}"Sleep time $sleep sec. ${blue}	|███████|███████|███████|███████|█████	|	(95%)\r"${reset}
	sleep "$sleep1"
	echo -ne ${green}"Sleep time $sleep sec. ${green}	|███████|███████|███████|███████|███████|      (100%)\r"${reset}
	sleep "$sleep1"
	echo -ne '\n'
	sleep=0
	sleep1=0
	sleep2=0
	}

##-------------------------=========== SEPARATOR =============-------------------------
## Simple function small bar to wait 3 sec. This bar does work with debian 12 & 13. Version 1.05

	functionsmallbar() {
		speed=0.2
		if [ "$debug" -eq 0 ]; then
			echo -ne ${yellow}'	TimeToQuit |                        |    (0%)\r'${reset}
			sleep $speed
			echo -ne ${yellow}'	TimeToQuit |  ██                    |   (10%)\r'${reset}
			sleep $speed
			echo -ne ${yellow}'	TimeToQuit |  ████                  |   (20%)\r'${reset}
			sleep $speed
			echo -ne ${yellow}'	TimeToQuit |  ██████                |   (30%)\r'${reset}
			sleep $speed
			echo -ne ${yellow}'	TimeToQuit |  ████████              |   (40%)\r'${reset}
			sleep $speed
			echo -ne ${yellow}'	TimeToQuit |  ██████████            |   (50%)\r'${reset}
			sleep $speed
			echo -ne ${yellow}'	TimeToQuit |  ████████████          |   (60%)\r'${reset}
			sleep $speed
			echo -ne ${yellow}'	TimeToQuit |  ██████████████        |   (70%)\r'${reset}
			sleep $speed
			echo -ne ${yellow}'	TimeToQuit |  ████████████████      |   (80%)\r'${reset}
			sleep $speed
			echo -ne ${yellow}'	TimeToQuit |  ██████████████████    |   (90%)\r'${reset}
			sleep $speed
			echo -ne ${yellow}'	TimeToQuit |  ████████████████████  |  (100%)\r'${reset}
			sleep $speed
			echo -ne '\n'
		else
			echo ${yellow} ████████████████████ DEBUG BYPASS functionfastbar ████████████████████${reset}
			sleep $speed
		fi
		}

## -------------------------===== Separator =====-------------------------
echo
part=$((part+1))
echo -------------------------===== Section $part =====-------------------------
	echo Check installed requirements !
	echo
if command -v ffmpeg >/dev/null 2>&1
	then
		echo "Ffmpeg installed continue."
		dpkg -s ffmpeg | grep Version
		echo "${green} ████████████████ OK ████████████████ ${reset}"
		echo
	else
		echo "You don't have ' ffmpeg ' installed."
		echo "Add with : sudo apt-get install ffmpeg"
		echo
		echo "${red}████████████████ Dependency error ████████████████${reset}"
		echo
		read -n 1 -s -r -p "Press ENTER key to continue anyway (NOT a good idea) !"
		echo
		echo
	fi

## -------------------------===== Separator =====-------------------------
part=1
echo -------------------------===== Section $part =====-------------------------
echo "All lowercase for convert... (NOT activated, activate it with lowercase=1)"
	echo

	if [ $lowercase -eq "1" ]; then
		echo
		## This line put all lowercase FROM selected folder to the files names.
		echo "cd "$file" && find . -name '*.*' -exec sh -c ' a=$(echo "$0" | sed -r "s/([^.]*)\$/\L\1/"); [ "$a" != "$0" ] && mv "$0" "$a" ' {} \;"
		cd "$file" && find . -name '*.*' -exec sh -c ' a=$(echo "$0" | sed -r "s/([^.]*)\$/\L\1/"); [ "$a" != "$0" ] && mv "$0" "$a" ' {} \;
		echo
		fi

part=$((part+1))
echo "-------------------------===== Section $part =====-------------------------"
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
	if [ $count -ge "1" ]; then
		echo Count : $count
		echo
		echo "You have selected :"
		echo "$file"
		echo
		fi

## -------------------------===== Separator =====-------------------------

### file or folder
	if test -z "$file"	## for cancel on zenity
		then
			echo "You click CANCEL !"
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
			echo "${yellow}█████████████████████ NO DATA TO PROCESS █████████████████████${reset}"
			echo
			read -n 1 -s -r -p "Press any key to continue"
			echo
			#exit
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

## -------------------------===== Separator =====-------------------------

if [ "$entry" -ge $2 ]; then
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
echo "Job lock Version 2,05"
	echo
	## local var
	runningjob=0
	#debug=1
	
	if [ -f /dev/shm/job.lock ]; then
		echo "${red} █████████ Lock-up already exist. Waiting for job finish. █████████ ${reset}"
		echo
		fi

## -------------------------===== Separator =====-------------------------

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
	
	if [ $runningjob -eq 1 ] ; then
		touch /dev/shm/job.lock
		runningjob=0
		fi
	
	choice=$?

## -------------------------===== Separator =====-------------------------

	if [ ! -f /dev/shm/job.lock ]; then
		echo "${blue} █████████ A lock will be created to prevent running multiples jobs. █████████ ${reset}"
		echo
		## Create a file to lock up!
		touch /dev/shm/job.lock
		runningjob=0
		fi

	if [ "$debug" -eq 1 ]; then
		echo
		debug
		echo "	Debug Job lock Unlock job"
		echo
		echo "	Debug job lock : choice = $choice runningjob = $runningjob"
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

	response=$(zenity --height=350 --width=450 --list --radiolist --text "Select sound output option" --column "Select" \
	--column "Sound_Type" FALSE "AAC" FALSE "MP3" FALSE "AC3" FALSE "DTS" TRUE "Copy" FALSE "None")

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
	## x264 10b aac
	parallel -a "/dev/shm/findvideo.txt" -j $entry ffmpeg -loglevel error -v error -stats -i \
	{} -vf format=yuv420p10le -c:v libx264 -crf 21 -preset faster -tune fastdecode -c:a aac {.}.{SDR-x264-10b}.{aac}.mkv
	error $?
	fi
	
	if [ $mp3 -eq 1 ]; then
	## x264 10b mp3
	parallel -a "/dev/shm/findvideo.txt" -j $entry ffmpeg -loglevel error -v error -stats -i \
	{} -vf format=yuv420p10le -c:v libx264 -crf 21 -preset faster -tune fastdecode -c:a mp3 {.}.{SDR-x264-10b}.{mp3}.mkv
	error $?
	fi
	
	if [ $ac3 -eq 1 ]; then	
	## x264 10b ac3
	parallel -a "/dev/shm/findvideo.txt" -j $entry ffmpeg -loglevel error -v error -stats -i \
	{} -vf format=yuv420p10le -c:v libx264 -crf 21 -preset faster -tune fastdecode -c:a ac3 {.}.{SDR-x264-10b}.{ac3}.mkv
	error $?
	fi
	
	if [ $dts -eq 1 ]; then	
	## x264 10b dts
	parallel -a "/dev/shm/findvideo.txt" -j $entry ffmpeg -loglevel error -v error -stats -i \
	{} -vf format=yuv420p10le -c:v libx264 -crf 21 -preset faster -tune fastdecode -strict experimental -c:a dts {.}.{SDR-x264-10b}.{dts}.mkv
	error $?
	fi
	
	if [ $copy -eq 1 ]; then
	## x264 10b copy
	parallel -a "/dev/shm/findvideo.txt" -j $entry ffmpeg -loglevel error -v error -stats -i \
	{} -vf format=yuv420p10le -c:v libx264 -crf 21 -preset faster -tune fastdecode -c:a copy {.}.{SDR-x264-10b}.{copy}.mkv
	error $?
	fi
	
	if [ $none -eq 1 ]; then
	## x264 10b none
	parallel -a "/dev/shm/findvideo.txt" -j $entry ffmpeg -loglevel error -v error -stats -i {} \
	-vf format=yuv420p10le -c:v libx264 -crf 21 -preset faster -tune fastdecode -an {.}.{SDR-x264-10b}.{none}.mkv
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
	
	#while true;do functionfastbar ; done &
	if zenity --question --timeout 12 --question --text="Do you want to move files to (Suggest yes) :\n\n ""$file"/"$subfolder"" ?"
	#kill $!; trap 'kill $!' SIGTERM
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
	echo "rm /dev/shm/findvideo.txt 2> /dev/null"
	rm "/dev/shm/findvideo.txt" 2> /dev/null
	echo

part=$((part+1))
echo "-------------------------===== Section $part =====-------------------------"
echo "Unlock ssh nodes. Version 1.04"
	echo

	if [ "$runningjob" -eq 0 ]; then
		rm "/dev/shm/job.lock" 2> /dev/null
		echo "${green} █████████ Computer released, new jobs available. █████████ ${reset}"
		echo
	else
		echo "${red} █████████ Had work in calculation and will not be unlocked. █████████ ${reset}"
		echo
		fi

part=$((part+1))
echo "-------------------------===== Section $part =====-------------------------"
echo "Software lead out. Version 5.21"

	printf '\033[8;25;90t'		## Will resize the window.

## -------------------------===== Separator =====-------------------------

	echo
	echo "Debug random : id=$id part=$part primeerror=$primeerror error=$error random=$random random2=$random2"
	echo
	echo "Debug : findsubfolders=$findsubfolders lowercase=$lowercase detox=$detox automatic=$automatic"
	echo "	debug=$debug debugcore=$debugcore minimize=$minimize maximize=$maximize reseize=$reseize noquit=$noquit"
	echo
	echo -------------------------===== End of Bash ======-------------------------
	echo
	echo "Finish... with numbers of actions : $part"
	echo "This script take $(( SECONDS - start )) seconds to complete."
	date=$(date -d@$(( SECONDS - start )) -u +%H:%M:%S)
	echo "Time needed: $date"
	now=$(date +"%Y-%m-%d_%A_%I:%M:%S")
	echo "Current time : $now"
	echo
	echo " " >>/dev/shm/logs.txt
	echo "$now (Time now)" >>/dev/shm/logs.txt
	echo "	Time needed : $date" >>/dev/shm/logs.txt
	echo "	Name of software : $me" >>/dev/shm/logs.txt
	echo "	Debug random : id=$id part=$part primeerror=$primeerror error=$error random=$random random2=$random2" >>/dev/shm/logs.txt
	echo "	Debug : findsubfolders=$findsubfolders lowercase=$lowercase detox=$detox automatic=$automatic debug=$debug debugcore=$debugcore minimize=$minimize maximize=$maximize reseize=$reseize noquit=$noquit" >>/dev/shm/logs.txt
	echo "	File (If any used) : $file" >>/dev/shm/logs.txt
	echo " " >>/dev/shm/logs.txt
	echo "--------------------====== SEPARATOR ========--------------------" >>/dev/shm/logs.txt

## -------------------------===== Separator =====-------------------------
## Exit, wait or auto-quit.

	if [ "$primeerror" -ge "1" ]; then
		printf '\033[8;35;90t'		## Will resize the window.
		#spd-say "$name have errors."
		echo
		echo "${red}████████████████████████████████████████████${reset}	${blue}████████████████████████████████████████${reset}"
		echo "${red}██                                        ██${reset}	${blue}██                                    ██${reset}"
		echo "${red}██     Unknown entry event... ERROR(S)    ██${reset}	${blue}██       Time needed : $date       ██${reset}"
		echo "${red}██                                        ██${reset}	${blue}██                                    ██${reset}"
		echo "${red}████████████████████████████████████████████${reset}	${blue}████████████████████████████████████████${reset}"
		echo
		echo "Numbers of error(s) : $primeerror"
		echo
		echo "Terminated : $me"
		echo
		#debug
		sleep=5
		functionsleepbar
		noquit=1
	else
		printf '\033[8;18;90t'		## Will resize the window.
		#spd-say "$name finished without errors."
		echo
		echo "${green}████████████████████████████████████████${reset}	${blue}████████████████████████████████████████${reset}"
		echo "${green}██                                    ██${reset}	${blue}██                                    ██${reset}"
		echo "${green}██         NO errors detected.        ██${reset}	${blue}██       Time needed : $date       ██${reset}"
		echo "${green}██                                    ██${reset}	${blue}██                                    ██${reset}"
		echo "${green}████████████████████████████████████████${reset}	${blue}████████████████████████████████████████${reset}"
		echo
		echo "Terminated : $me"
	fi

	if [ "$noquit" -eq "1" ]; then
		printf '\033[8;19;90t'		## Will resize the window.
		echo
		echo "${blue}	█████████████████ NO exit activated ███████████████████${reset}"
		echo
		read -n 1 -s -r -p "Press any key to EXIT or press X to close this windows !"
		echo
		fi

	if [ "$debug" -eq "1" ]; then
		debug
		echo "${blue}		█████ DEBUG WAIT | Program finish. █████${reset}"
		echo
		read -n 1 -s -r -p "Press any key to EXIT or press X to close this windows !"
		echo
		fi

	echo
	echo "${green}	███████████████ Finish, quit in 3 seconds █████████████████${reset}"
	echo
	functionsmallbar
	echo
	sleep 0.5
	exit 0

## -------------------------===== Start of eula =====-------------------------

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

## -------------------------===== End of file =====-------------------------
