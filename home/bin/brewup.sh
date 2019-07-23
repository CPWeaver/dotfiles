#!/usr/local/bin/bash

function error_exit {
  echo "$1" >&2
  exit "${2:-1}"
}

if [ $? -ne 0 ]; then
  error_exit "Error updating homebrew"
fi

while getopts :Hhw OPTION
do
  case $OPTION in 
    H) 
      echo "Updates homebrew dependencies"
      echo ""
      echo "Usage:"
      echo "$0 [-H] [-h] [-w]"
      echo " -H show help message"
      echo " -h include home Brewfile"
      echo " -w include work Brewfile"
      exit
      ;;
    h)
      INCLUDE_HOME=1
      ;;
    w)
      INCLUDE_WORK=1
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

if [ $INCLUDE_WORK ]; then
  echo "Including work bundle."
  brew bundle install -v --file=~/brewfiles/Brewfile-work
fi

if [ $INCLUDE_HOME ]; then
  echo "Including home bundle."
  brew bundle install -v --file=~/brewfiles/Brewfile-home
fi

if [ $? -ne 0 ]; then
  error_exit "Error updating work bundle"
fi

brew upgrade

brew cleanup
