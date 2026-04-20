#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

fail() {
  printf "FAIL: %s\n" "$1"
  exit 1
}

assert_file_contains() {
  local file_path="$1"
  local needle="$2"
  local message="$3"

  if ! grep -Fq "$needle" "$file_path"; then
    fail "$message"
  fi
}

[[ -f "$ROOT/home/.zprofile" ]] || fail "missing home/.zprofile"
[[ -f "$ROOT/home/.zshrc" ]] || fail "missing home/.zshrc"
[[ -f "$ROOT/.gitignore" ]] || fail "missing .gitignore"

assert_file_contains "$ROOT/home/.bash_profile" "[ -r ~/.bash_secrets ] && source ~/.bash_secrets" "missing guarded bash secrets load"
assert_file_contains "$ROOT/.gitignore" "home/.bash_secrets" "missing home/.bash_secrets in .gitignore"
assert_file_contains "$ROOT/.gitignore" "home/.extra" "missing home/.extra in .gitignore"
assert_file_contains "$ROOT/.gitignore" "home/.zextra" "missing home/.zextra in .gitignore"
assert_file_contains "$ROOT/home/.zprofile" "[ -r ~/.ssh/ssh-agent-setup ] && source ~/.ssh/ssh-agent-setup" "missing zsh ssh-agent bootstrap"
assert_file_contains "$ROOT/home/.zprofile" "[ -r ~/.homesick/repos/homeshick/homeshick.sh ] && source ~/.homesick/repos/homeshick/homeshick.sh" "missing zsh homeshick bootstrap"
assert_file_contains "$ROOT/home/.path" "brew --prefix grep" "missing bash grep PATH bootstrap via brew prefix"
assert_file_contains "$ROOT/home/.path" "brew --prefix ctags" "missing bash ctags PATH bootstrap via brew prefix"
assert_file_contains "$ROOT/home/.zpath" "brew --prefix grep" "missing zsh grep PATH bootstrap via brew prefix"
assert_file_contains "$ROOT/home/.zpath" "brew --prefix ctags" "missing zsh ctags PATH bootstrap via brew prefix"
assert_file_contains "$ROOT/home/.zpath" "brew --prefix rustup" "missing zsh rustup PATH bootstrap"
assert_file_contains "$ROOT/home/.zpath" "brew --prefix coreutils" "missing zsh coreutils PATH bootstrap"
assert_file_contains "$ROOT/home/.zpath" "brew --prefix gnu-sed" "missing zsh gnu-sed PATH bootstrap"
if grep -Fq "/usr/local/Cellar" "$ROOT/home/.path"; then
  fail "bash path file should not hardcode /usr/local/Cellar"
fi
if grep -Fq "/usr/local/Cellar" "$ROOT/home/.zpath"; then
  fail "zsh path file should not hardcode /usr/local/Cellar"
fi
if grep -Fq "home/.zsecrets" "$ROOT/.gitignore"; then
  fail "home/.zsecrets should not be present in .gitignore"
fi

zsh -n "$ROOT/home/.zprofile"
zsh -n "$ROOT/home/.zshrc"
bash -n "$ROOT/home/.bash_profile"

printf "PASS: shell smoke checks\n"
