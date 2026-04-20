#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
TEMP_HOME="$(mktemp -d)"

cleanup() {
  rm -rf "$TEMP_HOME"
}

trap cleanup EXIT

link_dotfile() {
  local dotfile="$1"
  ln -s "$ROOT/home/$dotfile" "$TEMP_HOME/$dotfile"
}

link_dotfile ".bash_aliases"
link_dotfile ".bash_functions"
link_dotfile ".bash_profile"
link_dotfile ".bashrc"
link_dotfile ".zaliases"
link_dotfile ".zfunctions"
link_dotfile ".zprofile"
link_dotfile ".zprompt"
link_dotfile ".zshrc"

assert_contains() {
  local needle="$1"
  local message="$2"
  if [[ "$PROBE_STDOUT" != *"$needle"* ]]; then
    printf "FAIL: %s\n" "$message"
    printf "Probe: %s\n" "$PROBE_NAME"
    printf "Exit code: %s\n" "$PROBE_EXIT_CODE"
    printf "stdout:\n%s\n" "$PROBE_STDOUT"
    printf "stderr:\n%s\n" "$PROBE_STDERR"
    exit 1
  fi
}

run_probe() {
  local probe_name="$1"
  shift

  local stdout_file
  local stderr_file
  stdout_file="$(mktemp)"
  stderr_file="$(mktemp)"

  local probe_exit_code
  set +e
  "$@" >"$stdout_file" 2>"$stderr_file"
  probe_exit_code=$?
  set -e

  PROBE_NAME="$probe_name"
  PROBE_EXIT_CODE="$probe_exit_code"
  PROBE_STDOUT="$(<"$stdout_file")"
  PROBE_STDERR="$(<"$stderr_file")"

  rm -f "$stdout_file" "$stderr_file"
}

run_probe "zsh alias/function/prompt probe" env -i HOME="$TEMP_HOME" ZDOTDIR="$TEMP_HOME" PATH="$PATH" zsh -ic 'alias g; alias ll; typeset -f wp; vcs_info; print -P -- "$PROMPT"'
assert_contains "wp ()" "zsh function wp missing"
assert_contains "g=git" "zsh alias g missing"
assert_contains "ll=" "zsh alias ll missing"
assert_contains " on" "zsh prompt missing git branch marker"

run_probe "bash alias probe" env -i HOME="$TEMP_HOME" PATH="$PATH" bash -ic 'alias g; alias ll'
assert_contains "alias g='git'" "bash alias g missing"
assert_contains "alias ll=" "bash alias ll missing"

printf "PASS: shell behavior checks\n"
