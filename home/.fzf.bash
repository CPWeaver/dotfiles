# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/chris/dev/tools/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/Users/chris/dev/tools/fzf/bin"
fi

eval "$(fzf --bash)"
