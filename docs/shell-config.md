# Shell configuration layout

This repo keeps shared shell behavior in tracked dotfiles and keeps secrets in local, ignored files.

## Tracked files

- `home/.bash_profile` loads Bash config and aliases for interactive shells.
- `home/.zprofile` and `home/.zshrc` provide Zsh login and interactive setup.
- `home/.bash_aliases`, `home/.bash_functions`, `home/.zaliases`, and `home/.zfunctions` keep reusable shell behavior.

## Local override files

- `home/.extra` is optional machine-local Bash config loaded by `home/.bash_profile`.
- `home/.bash_secrets` is optional and loaded only when readable.
- `home/.zextra` is the single local Zsh file for machine-specific aliases and secrets.
- Keep local secret-bearing files untracked.

## Validation

- `tests/shell/smoke.sh` checks shell config presence, parseability, and secret-hardening guardrails.
- `tests/shell/behavior.sh` verifies aliases and functions are available in isolated Bash and Zsh sessions.
