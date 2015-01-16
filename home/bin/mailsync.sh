#!/bin/bash

while true;
do
  echo -n "Starting Sync..."
  mbsync -q -a
  code=$?
  if [ $code -ne 0 ]; then
    echo "Error: $code"
  else
    echo "Success!"
  fi
  date
  sleep 4m
done
