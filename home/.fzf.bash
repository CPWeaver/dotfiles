# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/chris/dev/tools/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/Users/chris/dev/tools/fzf/bin"
fi

# Auto-completion
# ---------------
source "/Users/chris/dev/tools/fzf/shell/completion.bash"

# Key bindings
# ------------
source "/Users/chris/dev/tools/fzf/shell/key-bindings.bash"
