#!/bin/bash
command_exists () {
      type "$1" &> /dev/null ;
      #echo "command $1 status $?"
}

if command_exists open; then
  open -W $1
else
  if command_exists xdg-open ; then
    xdg-open $1
  fi
fi
