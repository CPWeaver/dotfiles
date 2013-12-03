# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Load the shell dotfiles, and then some:
# # * ~/.path can be used to extend `$PATH`.
# # * ~/.extra can be used for other settings you don't want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
  [ -r "$file" ] && source "$file"
done
unset file

# Setup or bind to running ssh agent 
if [ -r ~/.ssh/ssh-agent-setup ]; then
  . $HOME/.ssh/ssh-agent-setup
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

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# Load hue automatically by adding
# the following to ~/.bash_profile:
export HUE_SCRIPT="/home/cweaver/dev/hue/bin/hue"
if [ -r $HUE_SCRIPT ]; then
  eval "$($HUE_SCRIPT init -)"
fi

# init rbenv if it exists
if [ type rbenv >/dev/null 2>&1 ]; then
  eval "$(rbenv init -)" 
fi


# Ensure you have set the following environment variables
export DEPLOY_DIR=/home/cweaver/dev/deploy

export GRAILS_HOME=/home/cweaver/grails/grails

export PATH=/opt/firefox:/opt/thunderbird:$HOME/.rbenv/bin:$PATH:~/dev/deploy:/opt/mat:/opt/visualvm/visualvm_135/bin:/opt/jd-gui:$GRAILS_HOME/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$HOME/bin

export LD_LIBRARY_PATH=/usr/lib32

export GRADLE_OPTS="-Xmx1024m -Dorg.gradle.daemon=true"

#export JAVA_HOME=/usr/lib/jvm/java-6-openjdk
