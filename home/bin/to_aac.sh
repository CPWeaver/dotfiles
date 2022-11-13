#!/bin/bash



find "$1" -type f | while read file; do 
  echo "Working on $file"; 

  if [[ $file == *.flac ]] || [[ $file == *.mp3 ]] || [[ $file == *.m4a ]]
  # if [[ $file == *.flac ]]
  then 
    basename=${file##*/}
    basename=${basename%.*}; 
    # echo "Basename: $basename"; 
    dirname="$(dirname -- "$file")";
    #echo "Dirname: $dirname";
    mkdir -p "../aac/$dirname";
    dest="../aac/$dirname/$basename.m4a";
    #echo "Dest: $dest";
    ffmpeg -n -nostdin -i "$file" -c:v copy -c:a libfdk_aac -vbr 4 "$dest";
    wait
  else 
    echo "non-flac file; copying directly";
    mkdir -p "../aac/$dirname";
    rsync -avzPp "$file" "../aac/$file"
  fi

done

