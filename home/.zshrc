[[ -o interactive && ! -o login ]] && source ~/.zprofile

if [[ -o interactive ]]; then
  autoload -Uz compinit
  compinit
fi

setopt HIST_IGNORE_DUPS HIST_IGNORE_SPACE HIST_VERIFY
bindkey -v
bindkey -M vicmd 'jk' vi-cmd-mode

for file in ~/.zaliases ~/.zfunctions; do
  [[ -r "$file" ]] && source "$file"
done
unset file

if command -v brew >/dev/null 2>&1; then
  nvm_sh="$(brew --prefix nvm 2>/dev/null)/nvm.sh"
  if [[ -r "$nvm_sh" ]]; then
    export NVM_DIR="$HOME/.nvm"
    source "$nvm_sh"
  fi
elif [[ -r "$HOME/.nvm/nvm.sh" ]]; then
  export NVM_DIR="$HOME/.nvm"
  source "$HOME/.nvm/nvm.sh"
fi
unset nvm_sh

if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

[[ -r ~/.fzf.zsh ]] && source ~/.fzf.zsh
