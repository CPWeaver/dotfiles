#!/usr/local/bin/bash

function error_exit {
  echo "$1" >&2
  exit "${2:-1}"
}

if [ $? -ne 0 ]; then
  error_exit "Error updating homebrew"
fi

while getopts :hw OPTION
do
  case $OPTION in 
    h) 
      echo "Updates homebrew dependencies"
      echo ""
      echo "Usage:"
      echo "$0 [-h] [-w]"
      echo " -h show help message"
      echo " -w include work Brewfile"
      exit
      ;;
    w)
      WORK=1
      ;;
    \?) 
      error_exit "$0: unknown option -$OPTARG"
      ;;
  esac
done

brew update 

if [ $? -ne 0 ]; then
  error_exit "Error updating homebrew"
fi

brew bundle install -v --file=~/brewfiles/Brewfile

if [ $? -ne 0 ]; then
  error_exit "Error updating common bundle"
fi

if [ $WORK ]; then
  echo "Including work bundle."
  brew bundle install -v --file=~/brewfiles/Brewfile-work
fi

if [ $? -ne 0 ]; then
  error_exit "Error updating work bundle"
fi

brew upgrade

brew cleanup
