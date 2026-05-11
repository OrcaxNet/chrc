#!/bin/sh
#
# chrc - uninstall script
#   Removes chrc binary, optional profile data, and cleans up shell rc files.

set -e

CHRC_HOME="${CHRC_HOME:-$HOME/.chrc}"
BIN_PATH="$CHRC_HOME/chrc"

# --- Utils -----------------------------------------------------------

printf_bold() {
  printf '\033[1m%s\033[0m\n' "$*"
}

printf_dim() {
  printf '\033[2m%s\033[0m\n' "$*"
}

printf_err() {
  printf '\033[31m%s\033[0m\n' "$*" >&2
}

detect_shell_rc() {
  case "${SHELL:-}" in
    */zsh) printf '%s\n' "${ZDOTDIR:-$HOME}/.zshrc" ;;
    */bash) printf '%s\n' "$HOME/.bashrc" ;;
    *)
      [ -f "$HOME/.zshrc" ] && printf '%s\n' "$HOME/.zshrc" && return 0
      [ -f "$HOME/.bashrc" ] && printf '%s\n' "$HOME/.bashrc" && return 0
      printf '%s\n' "$HOME/.profile"
      ;;
  esac
}

remove_sourcing() {
  RCFILE="$1"
  tmp="${RCFILE}.chrcbak"

  # Remove the 4-line block that install.sh added
  # (the blank line, # chrc comment, export, and source line)
  awk '
    /^# chrc - shell runcom switcher/ { skip=4; next }
    skip > 0 { skip--; next }
    { print }
  ' "$RCFILE" > "$tmp" 2>/dev/null && mv "$tmp" "$RCFILE"

  # Also remove old-style single-line sourcing that the README used to suggest
  awk '
    /^export CHRC_HOME.*chrc/ && /chrc/ { next }
    /^# chrc - / { next }
    /^\[ -s .*chrc\]/ { next }
    { print }
  ' "$RCFILE" > "${RCFILE}.chrcbak2" 2>/dev/null && mv "${RCFILE}.chrcbak2" "$RCFILE"

  printf_dim "    cleaned up $RCFILE"
}

# --- Phases ----------------------------------------------------------

confirm_remove_profiles() {
  printf 'Remove all profiles in %s? [y/N] ' "$CHRC_HOME"
  read -r answer
  case "$answer" in
    y|Y|yes|YES) return 0 ;;
    *) return 1 ;;
  esac
}

do_uninstall() {
  printf_bold "==> chrc uninstall"

  # 1. Remove binary
  if [ -f "$BIN_PATH" ]; then
    rm -f "$BIN_PATH"
    printf_dim "    removed $BIN_PATH"
  else
    printf_dim "    chrc not found at $BIN_PATH"
  fi

  # 2. Clean up shell rc file
  RCFILE="$(detect_shell_rc)"
  if [ -f "$RCFILE" ]; then
    remove_sourcing "$RCFILE"
  fi

  # 3. Offer to remove profiles
  if [ -d "$CHRC_HOME" ]; then
    if confirm_remove_profiles; then
      rm -rf "$CHRC_HOME"
      printf_dim "    removed $CHRC_HOME (all profiles)"
    else
      printf_dim "    kept $CHRC_HOME (profiles preserved)"
    fi
  fi

  printf_bold "\n==> chrc has been uninstalled."
  printf_dim "    Restart your shell or run 'exec \$SHELL' to complete cleanup.\n"
}

# --- Entry point -----------------------------------------------------

do_uninstall "$@"
