#!/bin/bash

command_exists () {
      type "$1" &> /dev/null ;
      #echo "command $1 status $?"
}

# pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U
pip3 list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip3 install -U

pip3 install neovim

# init nvm if it exists
if command_exists brew ; then
  export NVM_DIR="$HOME/.nvm"
  source "$(brew --prefix nvm)/nvm.sh"
else
  if [ -e "$HOME/.nvm/nvm.sh" ]; then
    export NVM_DIR=~/.nvm
    source "$HOME/.nvm/nvm.sh"
  fi
fi
nvm install lts/* --reinstall-packages-from=node

