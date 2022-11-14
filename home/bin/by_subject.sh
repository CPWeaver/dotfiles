#!/bin/bash

#first, apply sidecar data to original images
# IFS=$'\n'
# for sidecar in $(find "$1" -name '*xmp')
# do
  # # filename=$(basename -- "$fullfile")
  # # extension="${filename##*.}"
  # original="${sidecar%.*}"
  # echo "SIDECAR: $sidecar"
  # # echo "EXT: $extension"
  # echo "ORIGINAL: $original"
  # exiftool -TagsFromFile "$sidecar" "$original"
  # exiftool -delete_original! "$sidecar" "$original"
# done

exiftool -preserve -progress -ext heic -tagsfromfile %d%f.%e.xmp -all:all -r $1
exiftool -preserve -progress -ext mov -tagsfromfile %d%f.%e.xmp -all:all -r $1
exiftool -preserve -progress -ext png -tagsfromfile %d%f.%e.xmp -all:all -r $1
exiftool -preserve -progress -ext jpg -tagsfromfile %d%f.%e.xmp -all:all -r $1
find $1 -name "*original" -delete


exiftool \
  -P \
  -progress \
  -r \
  '-filename<${createdate#;DateFmt("%Y")}-new/${createdate#;DateFmt("%m")}/${subject;}/${createdate#;DateFmt("%Y-%m-%d")}/Screenshot/%f.%e' \
  '-filename<${createdate#;DateFmt("%Y")}-new/${createdate#;DateFmt("%m")}/${subject;}/${createdate#;DateFmt("%Y-%m-%d")}/${model;}/%f.%e' \
  $1

# exiftool \
  # -preserve \
  # -progress \
  # -r \
  # '-testname<${createdate#;DateFmt("%Y")}-new/${createdate#;DateFmt("%m")}/${subject;}/${createdate#;DateFmt("%Y-%m-%d")}/Screenshot/%f.%e' \
  # '-testname<${createdate#;DateFmt("%Y")}-new/${createdate#;DateFmt("%m")}/${subject;}/${createdate#;DateFmt("%Y-%m-%d")}/${model;}/%f.%e' \
  # $1

find "$1" -type d -empty -delete

# next, make directories by subject
# IFS=$'\n'
# for sidecar in $(find "$1" -iname '*xmp' -o -iname '*heic' -o -iname '*mov' -o -iname '*png' -o -iname '*jpg')

# do
  # dir=$(dirname "$sidecar")
  # file=$(basename "$sidecar")
  # # extension="${filename##*.}"
  # # original="${sidecar%.*}"
  # # echo "SIDECAR: $sidecar"
  # # echo "DIR: $dirname"
  # month=$(echo "${dir%%/*}")
  # rest=$(echo "${dir#*/}")
  # possible_subject=$(echo "${dir}" | cut -d'/' -f2)

  # echo "MONTH: $month"
  # echo "REST: $rest"

  # subject=$(exiftool -s3 -Subject ${sidecar})
  # if [[ $subject == "" ]]; then
    # echo "NO SUBJECT: $sidecar"
    # continue
  # fi
    
  # echo "SUBJECT: $subject"
  # echo "FROM: $sidecar TO: $month/$subject/$rest/$file"

  # if [[ "$sidecar" =~ "$subject" ]]; then 
    # echo "ALREADY SORTED"
    # continue
  # fi

  # if [[ "$sidecar" == "$month/$subject/$rest/$file" ]]; then 
    # echo "NO CHANGE"
    # continue
  # fi

  # mkdir -p "$month/$subject/$rest"
  # cp -pr "$sidecar" "$month/$subject/$rest/$file"
  # rm "$sidecar"

# done

# find "$1" -type d -empty -delete


