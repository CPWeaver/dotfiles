[[ -o interactive ]] || return

if command -v brew >/dev/null 2>&1; then
  eval "$(brew shellenv)"
fi

for file in ~/.zpath ~/.zprompt ~/.zexports ~/.zextra; do
  [[ -r "$file" ]] && source "$file"
done
unset file

[ -r ~/.ssh/ssh-agent-setup ] && source ~/.ssh/ssh-agent-setup
[ -r ~/.homesick/repos/homeshick/homeshick.sh ] && source ~/.homesick/repos/homeshick/homeshick.sh
