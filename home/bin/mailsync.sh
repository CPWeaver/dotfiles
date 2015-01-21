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
    echo "Success!"
    notmuch new
  fi
  date
  sleep 4m
done
