#alias vi='gvim'
alias vi='nvim'
alias sa='source ~/.bash_aliases'
alias vb='vi ~/.bashrc'
alias sb='source ~/.bashrc'
alias va='vi ~/.bash_aliases'
alias sl='ls'
alias h='history'
alias mat='~/dev/tools/mat/MemoryAnalyzer -data temp/mat -vmargs -Xmx6g'
alias nodepath='export PATH=$(npm bin):$PATH'
alias docekr='docker'
alias d='docker'
alias g='git'

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

alias de='eval $(docker-machine env `docker-machine ls -q`)'
alias cat='bat'

# LS Aliases
ls_cmd="ls"
if type "gls" &> /dev/null ; then
  ls_cmd="gls"
fi

# Detect which `ls` flavor is in use
if ${ls_cmd} --color > /dev/null 2>&1; then # GNU `ls`
  colorflag="--color"
else # OS X `ls`
  colorflag="-G"
fi

alias ls="${ls_cmd} ${colorflag}"

# List all files colorized in long format
alias l="${ls_cmd} -l ${colorflag}"

# List all files colorized in long format, including dot files
alias la="${ls_cmd} -la ${colorflag}"

# List only directories
alias lsd="${ls_cmd} -l ${colorflag} | grep "^d""

# List with readable file sizes
alias ll="${ls_cmd} -alh ${colorflag}"

# some more ls aliases
alias ll="${ls_cmd} -l ${colorflag}"
#alias la='ls -A'
#alias l='ls -CF'

alias ag='rg'
