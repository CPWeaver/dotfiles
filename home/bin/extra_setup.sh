#!/bin/bash
if [ "$(uname)" == "Darwin" ]; then
  echo "Performing extra setup for MacOS..."
  # todo: brew
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
  echo "Performing extra setup for linux..."
  # Linux setup
  sudo apt-get update
  sudo apt-get install entr vim sed coreutils \
    fzf libutf8proc-dev libevent-dev bison \
    autotools-dev automake libncurses5-dev cmake \
    python3 pip bat ripgrep silversearcher-ag

  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

  nvm i --lts
  npm i -g yarn bash-language-server

  pip install pynvim
  go install github.com/nametake/golangci-lint-langserver@latest
  go install github.com/go-delve/delve/cmd/dlv@latest

  mkdir -p ~/dev/tools
  install_tools.sh

  bash <(curl -s https://raw.githubusercontent.com/CPWeaver/dot_vim/master/install)

fi

echo; echo "Extra setup complete!"
