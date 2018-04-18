#!/bin/bash -x


#Renames and organizes your music data.
#Provide the full path of your source music folder as an argument.
#Renames music files according to its metadata  in format "Artist - Title". 
#Creates a directory in the target folder with Artist name and stores file in it.


if [ -z "$1" ];then #setting default directory
	cd /home/mason/Music
else	
	cd "$1"
fi

target_dir='/home/mason/Music/test'

for F in ./*.mp3 #change this line to 'for F in ./*' if you have files other than mp3 format
do
	if [ -f "$F" ];then				
		artist=`mminfo "$F"|grep artist|awk -F: '{print $2}'` #getting metadata
		title=`mminfo "$F"|grep title|awk -F: '{print $2}'`
			if [  -n "$artist"  ] && [  -n "$title"  ];then
				filename="$artist - $(basename "$F")";#echo $filename
#				cp "$F" "$filename"  #renaming the file(copy)
#				mv "$filename" "$target_dir"

#					if [ -d "$target_dir/$artist" ];then    #moving file to the artist folder
#						mv "$filename" "$target_dir/$artist"  
#					else
#						mkdir "$target_dir/$artist"
#						mv "$filename" "$target_dir/$artist"
#					fi
			else
				echo -e "Skipping b/c insufficient metadata: $F \n"
				cp "$F" "$target_dir"
			fi
	fi
done
