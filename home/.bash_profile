# vim: filetype=sh
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

set -o vi
bind '"jk":vi-movement-mode'

# Load the shell dotfiles, and then some:
# # * ~/.path can be used to extend `$PATH`.
# # * ~/.extra can be used for other settings you don't want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,bash_functions,extra}; do
  [ -r "$file" ] && source "$file"
done
unset file

# Setup or bind to running ssh agent 
if [ -r ~/.ssh/ssh-agent-setup ]; then
  . "$HOME/.ssh/ssh-agent-setup"
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -r ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -r /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

if type brew >/dev/null 2>&1; then
  for file in $(brew --prefix)/etc/bash_completion.d/* ; do
    source "$file"
  done
  
  [[ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]] && . "$(brew --prefix)/etc/profile.d/bash_completion.sh"

  if [ -f "$(brew --prefix)/share/bash-completion/bash_completion" ]; then
    . "$(brew --prefix)/share/bash-completion/bash_completion"
  fi
fi

if [ -r "$HOME/.homesick/repos/homeshick/homeshick.sh" ]; then
  source "$HOME/.homesick/repos/homeshick/homeshick.sh"
fi

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
HISTCONTROL=$HISTCONTROL${HISTCONTROL+:}ignoredups
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Load hue automatically by adding
# the following to ~/.bash_profile:
export HUE_SCRIPT="/home/cweaver/dev/hue/bin/hue"
if [ -r $HUE_SCRIPT ]; then
  eval "$($HUE_SCRIPT init -)"
fi

if command_exists rbenv ; then
  eval "$(rbenv init -)" 
fi

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

# init virtualenv if it exists
export VIRTUALENV_WRAPPER=~/.local/bin/virtualenvwrapper.sh
if [ -r $VIRTUALENV_WRAPPER ]; then
  source $VIRTUALENV_WRAPPER
else 
  export VIRTUALENV_WRAPPER=~/Library/Python/2.7/bin/virtualenvwrapper.sh
  if [ -r $VIRTUALENV_WRAPPER ]; then
    export PATH=$PATH:${HOME}/Library/Python/2.7/bin
    source $VIRTUALENV_WRAPPER
  fi
fi

export VIM_HOME=/usr/local/Cellar/neovim/0.1.1/share/nvim/runtime
if [ ! -d $VIM_HOME ]; then
  export VIM_HOME=/usr/share/vim/vim74
fi


# Ensure you have set the following environment variables
export DEPLOY_DIR=/home/cweaver/dev/deploy

export GRAILS_HOME=/home/cweaver/grails/grails
export LD_LIBRARY_PATH=/usr/lib32

export GRADLE_OPTS="-Xmx2048m"

export EDITOR=nvim
export NVIM_LOG_FILE="$HOME/.nvimlog"

export HOSTNAME="$HOSTNAME"

export FZF_DEFAULT_COMMAND='rg --hidden --files --no-ignore'
# export FZF_DEFAULT_COMMAND='find .'

export BAT_THEME="Solarized (light)"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
