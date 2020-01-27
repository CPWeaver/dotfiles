# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/chrisweaver/dev/tools/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/Users/chrisweaver/dev/tools/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/Users/chrisweaver/dev/tools/fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/Users/chrisweaver/dev/tools/fzf/shell/key-bindings.bash"
