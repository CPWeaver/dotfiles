#!/bin/bash

#first, apply sidecar data to original images
IFS=$'\n'

for dir in $(find "$1" -type d -depth 2)
do
  subject=$(basename "$dir")
  echo "dir: $dir; subject: $subject"

  if  [[ $subject == 201* ]] ; then
    echo "Error: non-subject '$subject'"
    exit 1
  fi
done


for dir in $(find "$1" -type d -depth 2)
do
  # # filename=$(basename -- "$fullfile")
  # # extension="${filename##*.}"
  # original="${sidecar%.*}"
  subject=$(basename "$dir")
  # subject="${dir#$1/}"
  echo "dir: $dir; subject: $subject"

  if  [[ $subject == 201* ]] ; then
    echo "Found non-subject: $subject"
    exit 1
  fi

  exiftool \
    -P \
    -progress \
    -r \
    "-XMP:Subject+=$subject" \
    "-XMP-digiKam:TagsList+=$subject" \
    "$dir"

done
