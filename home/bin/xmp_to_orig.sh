#!/bin/bash

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


