#!/bin/bash

while true;
do
  echo -n "Starting Sync..."
  mbsync -q -a
  code=$?
  if [ $code -ne 0 ]; then
    echo "Error: $code"
    exit 1
  else
    echo -n "Indexing..."
    notmuch new
    if [ $code -ne 0 ]; then
      echo "Error: $code"
      exit 1
    else
      echo "Success!"
    fi
  fi
  date
  sleep 4m
done
