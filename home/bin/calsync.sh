#!/bin/bash

while true;
do
  echo -n "Starting Calendar Sync..."
  vdirsyncer sync
  code=$?
  if [ $code -ne 0 ]; then
    echo "Error: $code"
    exit 1
  else
    echo "Success!"
  fi
  date
  sleep 4m
done
