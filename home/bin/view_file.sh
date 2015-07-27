#!/bin/bash
command_exists () {
      type "$1" &> /dev/null ;
      #echo "command $1 status $?"
}

platform='unknown'
unamestr=$(uname)
if [[ "$unamestr" == 'Linux' ]]; then
  platform='linux'
elif [[ "$unamestr" == 'Darwin' ]]; then
  platform='osx'
fi

if [[ $platform == 'osx' ]]; then
  open -W "$1"
else
  if [[ $platform == 'linux' ]]; then
    xdg-open "$1"
  fi
fi
