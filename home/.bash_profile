# vim: filetype=sh
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# on mac, /etc/profile runs "path_helper" that unconditionally
# prepends /etc/paths and /etc/paths.d contents to your PATH.
# When run in tmux it overwrites any reordering done below and/or
# duplicates entries. Clearing path and sourcing it manually results
# in a consistent path regardless of if nested in tmux or not.
if [ -f /etc/profile ] && grep -q path_helper /etc/profile; then
  PATH=""
  source /etc/profile
fi

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
  if [[ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]] ; then
    . "$(brew --prefix)/etc/profile.d/bash_completion.sh"
  fi
fi

if [ -r "$HOME/.homesick/repos/homeshick/homeshick.sh" ]; then
  source "$HOME/.homesick/repos/homeshick/homeshick.sh"
fi

# # don't put duplicate lines in the history. See bash(1) for more options
# # don't overwrite GNU Midnight Commander's setting of `ignorespace'.
# HISTCONTROL=$HISTCONTROL${HISTCONTROL+:}ignoredups
# # ... or force ignoredups and ignorespace
# HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# # check the window size after each command and, if necessary,
# # update the values of LINES and COLUMNS.
# shopt -s checkwinsize

# # make less more friendly for non-text input files, see lesspipe(1)
# #[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

export LANG=en_US.UTF-8

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

if command_exists gdircolors ; then
  eval $(gdircolors ~/.dircolors)
fi

export EDITOR=nvim
export NVIM_LOG_FILE="$HOME/.nvimlog"

export HOSTNAME="$HOSTNAME"

export FZF_DEFAULT_COMMAND='rg --hidden --files --no-ignore'

export BAT_THEME="Solarized (light)"
export BAT_PAGER="less -RF --incsearch"

export PAGER=less

GPG_TTY=$(tty)
export GPG_TTY

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# pnpm
export PNPM_HOME="/Users/chris/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
