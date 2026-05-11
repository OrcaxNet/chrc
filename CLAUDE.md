# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Git & Commits

- Use identity: `claude` / `bot@orcax.net`
- After making changes, commit and push directly via `git commit` + `git push` unless the user says otherwise
- Commit messages should be concise, imperative mood, no period

## Project Overview

`chrc` (change runcom) is a single-file POSIX shell function for switching shell runcom snippets (profiles). Profiles are `.sh` files stored in `~/.chrc/`. The `chrc` script is sourced into the user's shell (`.zshrc`/`.bashrc`) and lazy-loads profiles on demand.

## Key Files

| File | Purpose |
|------|---------|
| `chrc` | The shell function — single file, self-contained |
| `install.sh` | One-liner install via curl (downloads `chrc` to `~/.chrc/chrc`, adds sourcing to rc file) |
| `uninstall.sh` | Removes binary, cleans rc file, optionally removes profiles |
| `README.md` | User-facing docs |

## Architecture

- **No dependencies** — pure POSIX shell (`/bin/sh`) with optional zsh/bash detection
- `~/.chrc/` is `CHRC_HOME` — all profiles (`*.sh`) and `.default` live there
- The `chrc` script itself installs to `~/.chrc/chrc`
- Profile loading sets `CHRC_SKIP_DEFAULT=1` to prevent recursive default-loading
- The `#desc <text>` comment on line 1 of a profile serves as its description

## Testing

This project has no test suite. Manual validation:
- `bash -n chrc` — syntax check
- Source the file in a subshell: `bash -c '. ./chrc && chrc help'`
