# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
HISTCONTROL=$HISTCONTROL${HISTCONTROL+:}ignoredups
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth

export GRADLE_OPTS="-Xmx1024m -Dorg.gradle.daemon=true"

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
#    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    PS1='${debian_chroot:+($debian_chroot)}\[\e[01;32m\]\u@\h\[\e[00m\]:\[\e[01;33m\]\w\[\e[00m\]$(__git_ps1 2>/dev/null) \$ '

else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

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

# some more ls aliases
alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

. $HOME/.ssh/ssh-agent-setup


# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

export GRAILS_HOME=/home/cweaver/grails/grails

export PATH=/opt/firefox:/opt/thunderbird:$HOME/.rbenv/bin:$PATH:~/dev/deploy:/opt/mat:/opt/visualvm/visualvm_135/bin:/opt/jd-gui:$GRAILS_HOME/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$HOME/bin

export LD_LIBRARY_PATH=/usr/lib32

#export JAVA_HOME=/usr/lib/jvm/java-6-openjdk


# Load hue automatically by adding
# the following to ~/.bash_profile:

eval "$(/home/cweaver/dev/hue/bin/hue init -)"

# Ensure you have set the following environment variables
export DEPLOY_DIR=/home/cweaver/dev/deploy





function tt {
	(
  	cd /usr/local/tomcat/logs
		tail -n 400 -F $@
	)
}

# chris custom functions
function c () {
   i=1
   while [ $i -le $1 ]
   do
      cd ../
      i=$[$i+1];
   done
}


function fc () { 
   find ~/dev/conference-center/src -type f -print0 2> /dev/null | xargs -0 grep -e $@
}

function ff () { 
   fc $@ | cut -d: -f1 | uniq | nl
 }

function gc () {
   line=$1
   shift;
   file=`ff $@ | sed -e "${line}q;d" | cut -f2`
   echo "LINE: $line FILE: $file"
   grep -C 5 "$@" $file
}

function jarGrep () {
   for jar in `find . -name "*.jar"`
   do
      jar tvf $jar | grep $@
      if [ $? == 0 ]; then
         echo $jar
      fi
   done
}

function sx () {
   sudo env DISPLAY="${DISPLAY}" XAUTHORITY=~/.XAuthority $@
}


eval "$(rbenv init -)"
#[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

source "$HOME/.homesick/repos/homeshick/homeshick.sh"