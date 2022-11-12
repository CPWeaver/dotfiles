#!/bin/bash

#first, apply sidecar data to original images
IFS=$'\n'
for sidecar in $(find "$1" -name '*xmp')
do
  # filename=$(basename -- "$fullfile")
  # extension="${filename##*.}"
  original="${sidecar%.*}"
  echo "SIDECAR: $sidecar"
  # echo "EXT: $extension"
  echo "ORIGINAL: $original"
  exiftool -TagsFromFile "$sidecar" "$original"
  exiftool -delete_original! "$sidecar" "$original"

done


# next, make directories by subject
IFS=$'\n'
for sidecar in $(find "$1" -iname '*xmp' -o -iname '*heic' -o -iname '*mov' -o -iname '*png' -o -iname '*jpg')
do
  dir=$(dirname "$sidecar")
  file=$(basename "$sidecar")
  # extension="${filename##*.}"
  # original="${sidecar%.*}"
  # echo "SIDECAR: $sidecar"
  # echo "DIR: $dirname"
  month=$(echo "${dir%%/*}")
  rest=$(echo "${dir#*/}")
  possible_subject=$(echo "${dir}" | cut -d'/' -f2)

  echo "MONTH: $month"
  echo "REST: $rest"

  subject=$(exiftool -s3 -Subject ${sidecar})
  if [[ $subject == "" ]]; then
    echo "NO SUBJECT: $sidecar"
    continue
  fi
    
  echo "SUBJECT: $subject"
  echo "FROM: $sidecar TO: $month/$subject/$rest/$file"

  if [[ "$sidecar" =~ "$subject" ]]; then 
    echo "ALREADY SORTED"
    continue
  fi

  if [[ "$sidecar" == "$month/$subject/$rest/$file" ]]; then 
    echo "NO CHANGE"
    continue
  fi

  mkdir -p "$month/$subject/$rest"
  cp -pr "$sidecar" "$month/$subject/$rest/$file"
  rm "$sidecar"

done

find "$1" -type d -empty -delete


