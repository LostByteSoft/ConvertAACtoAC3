#!/bin/bash
#!/usr/bin/ffmpeg
## -----===== Start of bash =====-----
	start=$SECONDS
	## "NEVER remove dual ## in front of lines. Theses are code annotations."
	## "You can test / remove single # for testing purpose."
	#printf '\033[8;50;80t'		# will resize the window, if needed.
	printf '\033[8;50;110t'		# will resize the window, if needed.
	sleep 0.50
	now=$(date +"%Y-%m-%d_%A_%H:%M:%S")
	red=`tput setaf 1`
	green=`tput setaf 2`
	yellow=`tput setaf 11`
	blue=`tput setaf 12`
	reset=`tput sgr0`
	echo
echo -------------------------========================-------------------------
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
	echo 2023-01-15_Sunday_05:13:41
	echo
	echo "Software name: Convert HDRtoSDR-SDR-x264-10b-DTS-48000hz-768k"
	echo
	echo What it does ?
	echo "Convert ONE video file HDR to SDR Convert HDRtoSDR-SDR-x264-10b-DTS-48000hz-768k"
	echo
	echo "Read me for this file (and known bugs) :"
	echo
	echo "Use 7z https://www.7-zip.org/download.html"
	echo "Use https://imagemagick.org/index.php"
	echo "Use Gnu Parallel https://www.gnu.org/software/parallel/"
	echo "Use ffmpeg https://ffmpeg.org/ffmpeg.html"
	echo
	echo "Options https://trac.ffmpeg.org/wiki/Encode/H.264"
	echo "4k demo HDR https://www.demolandia.net"
	echo
	echo "Informations : (EULA at the end of file, open in text.)"
	echo "By LostByteSoft, no copyright or copyleft. https://github.com/LostByteSoft"
	echo
	echo "Don't hack paid software, free software exists and does the job better."
	echo -------------------------========================-------------------------
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
		debug=1
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
	echo Check installed requirements !
	echo
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
	echo
echo -------------------------========================-------------------------
echo "Select folder or filename using dialog !"
	echo
	file="$(zenity --file-selection --file-filter="*.gif" --filename=$HOME/ --title="Select a file, all format supported")"	## File select.
	#file=$(zenity  --file-selection --filename=$HOME/ --title="Choose a directory to convert all file" --directory)	## Directory select.
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
	
	res=0		# automatic resolution detection and naming (720, 1080... etc)
	audio=0		# get numbers of channels
	echo "Get resolution and numbers of audio channel(s) of the multimedia file"
	res=`ffprobe -v error -select_streams v:0 -show_entries stream=height -of csv=s=x:p=0 "$file"`
	#res1=${res::-1}	#somes videos are detected with an X after the resution, this remove the X
	echo Resolution of the video : $res
	audio=`ffprobe -show_entries stream=channels -of compact=p=0:nk=1 -v 0 "$file"`
	echo Numbers of audio channel : $audio
	echo
	echo "$res"progressive-"$audio"channels
	echo "$res" p- "$audio" c
	echo
	error $?
	
part=$((part+1))
echo "-------------------------===== Section $part =====-------------------------"
echo "ffmpeg conversion, x265 options." DEACTIVATED

	### better compression and x265 {SDR.x265.10b}
#ffmpeg -i "$file" -vf zscale=t=linear:npl=100,format=gbrpf32le,zscale=p=bt709,tonemap=tonemap=hable:desat=0,zscale=t=bt709:m=bt709:r=tv,format=yuv420p10le -c:v libx265 -crf 18 -preset superfast -tune fastdecode -strict experimental -c:a dts -ar 48000 -b:a 768k "$name".{BluRay-"$res"p-5,1}.{SDR-x265-10b}.{dts}.mkv
error $?
	
part=$((part+1))
echo "-------------------------===== Section $part =====-------------------------"
echo "ffmpeg conversion, x264 options." ACTIVATED

	###Good quality and x264 {SDR.x264.10b} ## -r:v 30 ## crf 0=lossless 51=verybad

##Convert HDRtoSDR.SDR-x264-10b-ac3-640k
#ffmpeg -i "$file" -vf zscale=t=linear:npl=100,format=gbrpf32le,zscale=p=bt709,tonemap=tonemap=hable:desat=0,zscale=t=bt709:m=bt709:r=tv,format=yuv420p10le -c:v libx264 -crf 18 -preset faster -tune fastdecode -c:a ac3 -ar 48000 -b:a 640k "$name".{BluRay-"$res"p-5,1}.{SDR-x264-10b}.{ac3}.mkv
error $?

##Convert HDRtoSDR.SDR-x264-10b-dts-768k
ffmpeg -i "$file" -vf zscale=t=linear:npl=100,format=gbrpf32le,zscale=p=bt709,tonemap=tonemap=hable:desat=0,zscale=t=bt709:m=bt709:r=tv,format=yuv420p10le -c:v libx264 -crf 18 -preset faster -tune fastdecode -strict experimental -c:a dts -ac 6 -ar 48000 -b:a 768k "$name".{BluRay-2160p-5.1}.{SDR-x264-10b}.{dts}.mkv
error $?

##Convert HDRtoSDR-SDR-x264-10b-copy
#ffmpeg -i "$file" -vf zscale=t=linear:npl=100,format=gbrpf32le,zscale=p=bt709,tonemap=tonemap=hable:desat=0,zscale=t=bt709:m=bt709:r=tv,format=yuv420p10le -c:v libx264 -crf 18 -preset faster -tune fastdecode -c:a copy "$name".{BluRay-"$res"p-5,1}.{SDR-x264-10b}.{copy}.mkv
error $?

##Convert HDRtoSDR-SDR-x264-10b-none
#ffmpeg -i "$file" -vf zscale=t=linear:npl=100,format=gbrpf32le,zscale=p=bt709,tonemap=tonemap=hable:desat=0,zscale=t=bt709:m=bt709:r=tv,format=yuv420p10le -c:v libx264 -crf 18 -preset faster -tune fastdecode -an "$name".{BluRay-"$res"p-5,1}.{SDR-x264-10b}.{none}.mkv
error $?
	
echo Reconversion finish...

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
 		Pôle Nord, Canada
 		H0H 0H0

## -----===== End of file =====-----
