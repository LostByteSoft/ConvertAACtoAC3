#!/bin/bash
#!/usr/bin/ffmpeg
## -----===== Start of bash =====-----
	#printf '\033[8;50;80t'		# will resize the window, if needed.
	printf '\033[8;50;100t'		# will resize the window, if needed.
	sleep 0.50
	## "NEVER remove dual ## in front of lines. Theses are code annotations."
	## "You can test / remove single # for testing purpose."
echo
echo -------------------------========================-------------------------
	start=$SECONDS
	now=$(date +"%Y-%m-%d_%A_%H:%M:%S")
	red=`tput setaf 1`
	green=`tput setaf 2`
	yellow=`tput setaf 11`
	blue=`tput setaf 12`
	reset=`tput sgr0`
	## All variables 0 or 1
	autoquit=0	# autoquit anyway to script takes LESS than 2 min to complete.
	debug=0		# test debug
	error=0		# test error
	part=0		# don't change this value
	noquit=0	# No quit after all operations.
	random=$RANDOM	# Used for temp folders
	echo "Software lead-in. LostByteSoft ; https://github.com/LostByteSoft"
	echo
	echo "Current time : $now"
	echo "Common variables, you can changes theses variables as you wish to test."
	echo
	echo "Debug data : autoquit=$autoquit debug=$debug error=$error part=$part noquit=$noquit random=$random"
echo -------------------------========================-------------------------
	echo "Color codes / Informations."
	echo
	echo  "${green}	████████████████     ALL OK / ACTIVE      ████████████████ ${reset}"
	echo   "${blue}	████████████████      INFORMATION(S)      ████████████████ ${reset}"
	echo "${yellow}	████████████████   ATTENTION / INACTIVE   ████████████████ ${reset}"
	echo    "${red}	████████████████   FATAL ERROR / OFFLINE  ████████████████ ${reset}"
	echo
echo -------------------------========================-------------------------
	echo Version compiled on : Also serves as a version
	echo 2022-11-29_Tuesday_07:58:24
	echo
## Software name, what is this, version, informations.
	echo
## Software name, what is this, version, informations.
	echo "Software name: Convert ALL folder files to x264 aac (parallel)"
	echo "File name: Convert ALL folder sdr-x264-8b-aac-320k (parallel).sh"
	echo
	echo What it does ?
	echo "Convert ONE video file to sdr-x264-8b.aac-2.0-320k.mkv"
	echo "Perfect format for facebook."
	echo
	echo Informations :
	echo "Use ffmpeg only"
	echo "Informations : (EULA at the end of file, open in text.)"
	echo "By LostByteSoft, no copyright or copyleft."
	echo "https://github.com/LostByteSoft"
	echo
	echo "Don't hack paid software, free software exists and does the job better."
#echo -------------------------========================-------------------------
#	echo "${red}		███████████████████████████████████████████████${reset}"
#	echo "		SPACES ARE NOT SUPPORTED IN PARALLEL CONVERSION"
#	echo "${red}		███████████████████████████████████████████████${reset}"
#	echo -------------------------========================-------------------------
	#read -n 1 -s -r -p "Press any key to continue"

echo -------------------------========================-------------------------
echo "Check installed requirements !"

echo Function ${blue}█████${reset} Debug. Activate via source program debug=1.

	debug()
	if [ "$debug" -ge 1 ]; then
		echo
		echo "${blue}█████████████████████████████████ DEBUG ██████████████████████████████████${reset}"
		echo
		echo autoquit=$autoquit debug=$debug error=$error noquit=$quit count=$count part=$part random=$random
		echo
		echo cpu = $cpu defa = $defa defi = $defi defv = $defv defs = $defx defz = $defz
		echo
		echo file = $file
		echo
		echo Basedir = "$BASEDIR"
		echo 
		read -n 1 -s -r -p "Press any key to continue"
		echo
	fi
	
	if [ "$debug" -eq "1" ]; then
		echo
		echo "${blue}██████████████████████████████ DEBUG ACTIVATED ███████████████████████████${reset}"
		echo
		echo "Debug data : autoquit=$autoquit debug=$debug error=$error part=$part noquit=$noquit random=$random"
		echo
	fi

echo Function ${red}█████${reset} Error detector. Errorlevel show error msg.

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

echo Function ${green}█████${reset} Auto Quit. If autoquit=1 will automaticly quit.
	if [ "$autoquit" -eq "1" ]; then
		echo
		echo "${green}████████████████████████████ AUTO QUIT ACTIVATED █████████████████████████${reset}"
		echo
	fi
	echo
echo -------------------------========================-------------------------
if command -v ffmpeg >/dev/null 2>&1
	then
		echo "Ffmpeg installed continue."
		dpkg -s ffmpeg | grep Version
	else
		echo "You don't have ' parallel ' installed, now exit in 10 seconds."
		echo "Add with : sudo apt-get install ffmpeg"
		echo
		echo "${red}████████████████ Dependency error ████████████████${reset}"
		echo
		read -n 1 -s -r -p "Press ENTER key to exit !"
		echo
		exit
	fi
## -------------------------========================-------------------------
if command -v parallel >/dev/null 2>&1
	then
		echo "Parallel installed continue."
		dpkg -s parallel | grep Version
	else
		echo "You don't have ' parallel ' installed, now exit in 10 seconds."
		echo "Add with : sudo apt-get install parallel"
		echo
		echo "${red}████████████████ Dependency error ████████████████${reset}"
		echo
		read -n 1 -s -r -p "Press ENTER key to exit !"
		echo
		exit
	fi

echo -------------------------========================-------------------------
echo "Number of jobs processed concurrently at the same time ? (Refer as parallel CPU cores)"
	cpu=$(nproc)
	defx=$(( cpu / 2 ))	## for audio files
	defv=$(( cpu / 4 ))	## for video files
	defi=$(( cpu * 2 ))	## for images files
	defy=$(( cpu * 4 ))	## for images files
	defz=$(( cpu * 8 ))	## for images files

	## Put an # in front of entry to do an automatic choice.

	entry=$(zenity --scale --value="2" --min-value="1" --max-value="$cpu" --title "Convert files with Multi Cores Cpu" --text "How many cores do you want to use ? You have "$cpu" total cores !\n\n\tDefault suggested value is "$defv" for video.\n\n\tDefault suggested value is "$defx" for audio.\n\n\tDefault suggested value is ("$cpu" xbrzscale) "$defi" for images.\n\n(1 to whatever core you want to use will work anyway !)")

if test -z "$entry"
	then
		echo "Default value of "$cpu" (Safe value) will be used. Now continue."
		entry=$defv
		echo "You have selected : $entry"
		#sleep 3
	else
		echo "You have selected : $entry"
	fi

if [ "$entry" -ge $defi ]; then
	part=$((part+1))
	echo
	echo "${yellow}█████████████████████████████ WARNING █████████████████████████████${reset}"
	echo
	echo "!!! You have chosen a very high parallel work value, this may slow down the calculation rather than speed it up !!!"
	echo
	read -n 1 -s -r -p "Press any key to CONTINUE"
	echo
	fi

echo -------------------------========================-------------------------
echo "Select folder or filename using dialog !"
	echo
	#file="$(zenity --file-selection --filename=$HOME/ --title="Select a file, all format supported")"			## File select.
	file=$(zenity  --file-selection --filename=$HOME/ --title="Choose a directory to convert all file" --directory)		## Directory select.
	#file="/$HOME/Pictures/"
	#file="/$HOME/Downloads/"
	## --file-filter="*.jpg *.gif"

	count=`ls -1 "$file" 2>/dev/null | wc -l`
	echo Count : $count
	echo "You have selected :"
	echo "$file"
	echo

### file or folder
	if test -z "$file"	## for cancel on zenity
		then
			echo "You click CANCEL !"
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
			echo -------------------------========================-------------------------
			echo
			echo "${yellow}█████████████████████ NO DATA TO PROCESS █████████████████████${reset}"
			echo
			read -n 1 -s -r -p "Press any key to EXIT"
			echo
			exit
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
	
	if [ "$debug" -eq "1" ]; then
		echo
		echo "${yellow}█████ DEBUG SLEEP (5 sec) █████${reset}"
		echo
		echo "Debug data : autoquit=$autoquit debug=$debug error=$error part=$part noquit=$noquit random=$random"
		sleep 5
		echo
	fi
echo	
echo -------------------------========================-------------------------
echo "All lowercase for convert... (NOT activated, remove both # to activate)"
	## This line put all lowercase FROM selected folder to the files names.
	#echo "cd "$file" && find . -name '*.*' -exec sh -c ' a=$(echo "$0" | sed -r "s/([^.]*)\$/\L\1/"); [ "$a" != "$0" ] && mv "$0" "$a" ' {} \;"
	#cd "$file" && find . -name '*.*' -exec sh -c ' a=$(echo "$0" | sed -r "s/([^.]*)\$/\L\1/"); [ "$a" != "$0" ] && mv "$0" "$a" ' {} \;

echo -------------------------========================-------------------------
## The code program.

part=$((part+1))
echo "-------------------------===== Section $part =====-------------------------"
echo Finding files...

	rm "/dev/shm/findvideo.txt" 2> /dev/null
	## Easy way to add a file format, copy paste a new line.
	echo "Will NOT find files in sub folders...."
	#find $file -iname '*.*'  >> "/dev/shm/findvideo.txt"
	find $file -maxdepth 1 -iname '*.mp4'  >> "/dev/shm/findvideo.txt"
	find $file -maxdepth 1 -iname '*.webm'  >> "/dev/shm/findvideo.txt"
	find $file -maxdepth 1 -iname '*.mkv'  >> "/dev/shm/findvideo.txt"
	find $file -maxdepth 1 -iname '*.avi'  >> "/dev/shm/findvideo.txt"

echo Finding finish.
part=$((part+1))
echo "-------------------------===== Section $part =====-------------------------"
	cat "/dev/shm/findvideo.txt"
	
part=$((part+1))
echo "-------------------------===== Section $part =====-------------------------"
	echo Finding finish, with file count :
	lines=$(wc -l < "/dev/shm/findvideo.txt")
	echo $lines
	if [ "$lines" -eq "0" ]; then
		echo "You don't have selected a folder with files, now exit in 3 seconds."
		echo -------------------------========================-------------------------
		sleep 3
		exit
	fi

part=$((part+1))
echo "-------------------------===== Section $part =====-------------------------"
echo Conversion started...

	echo "Parallel convert"

	### x264 8b
	
	
parallel -a "/dev/shm/findvideo.txt" -j $entry ffmpeg -i {}-vf format=yuv420p10le -c:v libx264 -crf 20 -c:a aac -ac 2 -b:a 320k {.}.{SDR-x264-10b}.{aac-2.0-320k}.mkv

#parallel -a "/dev/shm/findvideo.txt" -j $entry ffmpeg -i {} -vf scale=1280x720:flags=lanczos,format=yuv420p -c:v libx264 -crf 22 -c:a aac -ac 2 -b:a 320k {.}.{SDR-x264-8b}.{aac-2.0-320k}.mkv
	
#parallel -j $entry ffmpeg -i {} -vf scale=1280x720:flags=lanczos,format=yuv420p -c:v libx264 -crf 22 -c:a aac -ac 2 -b:a 320k {.}.{SDR-x264-8b}.{aac-2.0-320k}.mkv ::: "$file"/*.*
	
	#parallel -j $entry ffmpeg -i {} -vf format=yuv420p -c:v libx264 -crf 20 -c:a aac -b:a 320k {.}.{sdr-x264-8b}.{aac-2.0-320k}.mkv ::: "$file"/*.*
	
	### x264 10b
	#parallel -j 1 ffmpeg -i {} -vf format=yuv420p10le -c:v libx264 -crf 20 -c:a aac -ac 2 -b:a 192k {.}-x264-10b.aac-192k.mkv ::: "$file"/*.*
	
	### x265 10b
	#parallel -j $entry ffmpeg -i {} -vf format=yuv420p10le -c:v libx265 -crf 20 -c:a aac -ac 2 -b:a 192k {.}-x264-10b.aac-44khz-192k.mkv ::: "$file"/*.*
	
	error $?

	echo "Conversion finish..."

part=$((part+1))
echo "-------------------------===== Section $part =====-------------------------"
echo Make folders sub...
	## Variable
	subfolder=x264mkv
	ext=*-320k}.mkv
	finaldir="$file"/"$subfolder"
	echo "Final dir : $finaldir"

	echo Make dir...
	echo mkdir -p """$file""/$subfolder"
		mkdir -p """$file""/$subfolder"
		sleep 1
		echo
		
	echo "mv "$file"/$ext """$file""/$subfolder""
		
	mv "$file"/$ext """$file""/$subfolder"
	
	if [ "$debug" -eq "1" ]; then
		echo
		echo "${blue}		█████ DEBUG WAIT █████${reset}"
		echo
		echo "Debug data : autoquit=$autoquit debug=$debug error=$error part=$part noquit=$noquit random=$random"
		echo
		read -n 1 -s -r -p "Press ENTER key to continue !"
		echo
	fi

## -------------------------========================-------------------------
## first folder
	echo Origin : $file
	#file=$(zenity  --file-selection --filename=$HOME/ --title="Choose a directory to convert all file" --directory)
	count1=`find "$file" -maxdepth 1 -type f | wc -l`
	echo Count 1 = $count1

## -------------------------========================-------------------------
## second folder
	file2="""$file"/"$subfolder"
	#file2=$(zenity  --file-selection --filename=$HOME/ --title="Choose a directory to convert all file" --directory)
	echo Save : """$file"/"$subfolder"
	count2=`find $file2 -maxdepth 1 -type f | wc -l`
	echo Count 2 = $count2
	
## -------------------------========================-------------------------
echo Total numbers of files in folders :
	echo
	echo "Origin folder : $count1 | Modified or results : $count2"
	echo
	echo "The answer is .... :"
	
	if [ "$debug" -eq "1" ]; then
		echo
		echo "${blue}		█████ DEBUG WAIT █████${reset}"
		echo
		echo "Debug data : autoquit=$autoquit debug=$debug error=$error part=$part noquit=$noquit random=$random"
		echo
		echo Count1 = $count1 Count2 = $count2
		echo
		read -n 1 -s -r -p "Press ENTER key to continue !"
		echo
	fi
	
	if [ "$count2" -eq 0 ]; then
			echo
			echo "		${red}████████████████████████████████████████████${reset}"
			echo "		${red}██                                        ██${reset}"
			echo "		${red}██     Numbers of files are NOT EQUAL     ██${reset}"
			echo "		${red}██                                        ██${reset}"
			echo "		${red}████████████████████████████████████████████${reset}"
			echo
			noquit=1	# No quit after detecting an error.
		fi
	
	if [ "$count2" -ne 0 ]; then
		if [ "$count1" = "$count2" ]; then
			echo
			echo "		${green}████████████████████████████████████████${reset}"
			echo "		${green}██                                    ██${reset}"
			echo "		${green}██     Numbers of files are EQUAL     ██${reset}"
			echo "		${green}██                                    ██${reset}"
			echo "		${green}████████████████████████████████████████${reset}"
		else
			echo
			echo "		${red}████████████████████████████████████████████${reset}"
			echo "		${red}██                                        ██${reset}"
			echo "		${red}██     Numbers of files are NOT EQUAL     ██${reset}"
			echo "		${red}██                                        ██${reset}"
			echo "		${red}████████████████████████████████████████████${reset}"
			echo
			
			noquit=1	# No quit after detecting an error.
			
			rm "/dev/shm/file1.txt" 2> /dev/null
			rm "/dev/shm/file2.txt" 2> /dev/null
			rm "/dev/shm/file11.txt" 2> /dev/null
			rm "/dev/shm/file22.txt" 2> /dev/null

		## fi after files check if numbers are not equal
## -------------------------========================-------------------------
## Finding files... if not equal
	#echo "Will NOT find files in sub folders..."
	cd "$file" && find -maxdepth 1 -name "*.*" | rev | cut -f 2- -d '.' | rev >> "/dev/shm/file1.txt"
	#cat "/dev/shm/file1.txt"
	## Finding files... 2
	#echo "Will NOT find files in sub folders..."
	cd "$file2" && find -maxdepth 1 -name "*.*" | rev | cut -f 2- -d '_' | rev >> "/dev/shm/file2.txt"
	#cat "/dev/shm/file2.txt"
	sort /dev/shm/file1.txt > /dev/shm/file11.txt
	sort /dev/shm/file2.txt > /dev/shm/file22.txt
	sed -i '1d' "/dev/shm/file11.txt"	## remove first line
	sed -i '1d' "/dev/shm/file22.txt"
	
echo -------------------------========================-------------------------
echo Verify 2 files for differences.
	echo
	echo diff -s -q "/dev/shm/file11.txt" "/dev/shm/file22.txt"
	echo
	diff -s -q "/dev/shm/file11.txt" "/dev/shm/file22.txt"
	active=$(echo $?)
	#echo $active
		if [ "$active" -ge "1" ]
			then
			echo
			echo "${red} ███████████████ VERIFY FILES ███████████████ ${reset}"
			fi
		if [ "$active" -eq "0" ]
			then
			echo
			echo "${green} ██████████████████████████████ ${reset}"
			fi

	echo
echo -------------------------========================-------------------------
echo Comparaison of files :
	echo
	echo diff --side-by-side --suppress-common-lines "/dev/shm/file11.txt" "/dev/shm/file22.txt"
	echo
	diff --side-by-side --suppress-common-lines "/dev/shm/file11.txt" "/dev/shm/file22.txt"

	active=$(echo $?)
	#echo $active
		if [ "$active" -ge "1" ]
			then
			echo
			echo "${red} ███████████████ VERIFY FILES ███████████████ ${reset}"
			fi
		if [ "$active" -eq "0" ]
			then
			echo
			echo "${green} ██████████████████████████████ ${reset}"
			fi
		#echo Remove temp files...
		rm "/dev/shm/file1.txt" 2> /dev/null
		rm "/dev/shm/file2.txt" 2> /dev/null
		rm "/dev/shm/file11.txt" 2> /dev/null
		rm "/dev/shm/file22.txt" 2> /dev/null		
	## ending of if
	fi
	fi
	echo
echo -------------------------========================-------------------------

echo -------------------------========================-------------------------
## Software lead out
	echo "Finish... with numbers of actions : $part"
	echo "This script take $(( SECONDS - start )) seconds to complete."
	date=$(date -d@$(( SECONDS - start )) -u +%H:%M:%S)
	echo "Time needed: $date"
	now=$(date +"%Y-%m-%d_%A_%I:%M:%S")
	echo "Current time : $now"
	echo
echo -------------------------========================-------------------------
	echo "If a script takes MORE than 120 seconds to complete it will ask"
	echo "you to press ENTER to terminate."
	echo
	echo "If a script takes LESS than 120 seconds to complete it will auto"
	echo "terminate after 10 seconds"
echo -------------------------========================-------------------------
## Exit, wait or auto-quit.
	if [ "$noquit" -eq "1" ]; then
		echo
		echo "${blue}	█████████████████ NO exit activated ███████████████████${reset}"
		echo
		read -n 1 -s -r -p "Press ENTER key to exit !"
		exit
		fi

	if [ "$autoquit" -eq "1" ]
		then
			echo
			echo "${green}	███████████████ Finish, quit in 3 seconds █████████████████${reset}"
			echo
			sleep 2
			echo
		else
		{
			if [ "$debug" -eq "1" ]; then
				echo
				echo "${blue}		█████ DEBUG WAIT | Program finish. █████${reset}"
				echo
				echo "Debug data : autoquit=$autoquit debug=$debug error=$error part=$part noquit=$noquit random=$random"
				echo
				read -n 1 -s -r -p "Press ENTER key to continue !"
				echo
			fi
		if [ $(( SECONDS - start )) -gt 120 ]
			then
				echo
				echo "Script takes more than 120 seconds to complete."
				echo
				echo "${blue}	█████████████████████ Finish ███████████████████████${reset}"
				echo
				read -n 1 -s -r -p "Press ENTER key to exit !"
				echo
			else
				echo
				echo "Script takes less than 120 seconds to complete."
				echo
				echo "${green}	█████████████████████ Finish ███████████████████████${reset}"
				echo
				echo "Auto-quit in 3 sec. (You can press X)"
				echo
				sleep 3
			fi
		}
		fi
	exit

## -----===== End of bash =====-----

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
 		Pôle Nord
 		H0H 0H0
 		Canada

## -----===== End of file =====-----

