#!/bin/sh
#
# chrc - install script
#   Usage: curl -fsSL https://raw.githubusercontent.com/OrcaxNet/chrc/main/install.sh | sh

set -e

REPO="OrcaxNet/chrc"
BRANCH="main"
URL="https://raw.githubusercontent.com/$REPO/$BRANCH/chrc"

CHRC_HOME="${CHRC_HOME:-$HOME/.chrc}"
BIN_PATH="$CHRC_HOME/chrc"

# --- Utils -----------------------------------------------------------

printf_bold() {
  printf '\033[1m%s\033[0m\n' "$*"
}

printf_dim() {
  printf '\033[2m%s\033[0m\n' "$*"
}

detect_shell_rc() {
  case "${SHELL:-}" in
    */zsh) printf '%s\n' "${ZDOTDIR:-$HOME}/.zshrc" ;;
    */bash) printf '%s\n' "$HOME/.bashrc" ;;
    *)
      # Fallback: check which rc files exist
      [ -f "$HOME/.zshrc" ] && printf '%s\n' "$HOME/.zshrc" && return 0
      [ -f "$HOME/.bashrc" ] && printf '%s\n' "$HOME/.bashrc" && return 0
      printf '%s\n' "$HOME/.profile"
      ;;
  esac
}

already_sourced() {
  grep -qE '(^\s*\[ -s .*chrc/chrc.*\]|^\s*\. .*chrc/chrc)' "$1" 2>/dev/null
}

# --- Phases ----------------------------------------------------------

install_binary() {
  printf_bold "==> Downloading chrc…"
  mkdir -p "$CHRC_HOME"

  if command -v curl >/dev/null 2>&1; then
    curl -fsSL -o "$BIN_PATH" "$URL"
  elif command -v wget >/dev/null 2>&1; then
    wget -q -O "$BIN_PATH" "$URL"
  else
    printf 'chrc: need either curl or wget to install\n' >&2
    exit 1
  fi

  chmod +x "$BIN_PATH"
  printf_dim "    installed at $BIN_PATH"
}

setup_rcfile() {
  if [ -z "${SKIP_RC:-}" ]; then
    RCFILE="$(detect_shell_rc)"
    printf_bold "==> Configuring shell rc file…"
    printf_dim "    detected: $RCFILE"

    if already_sourced "$RCFILE"; then
      printf_dim "    already configured, skipping"
    else
      {
        printf '\n'
        printf '# chrc - shell runcom switcher\n'
        printf 'export CHRC_HOME="$HOME/.chrc"\n'
        printf '[ -s "$HOME/.chrc/chrc" ] && . "$HOME/.chrc/chrc"\n'
      } >> "$RCFILE"
      printf_dim "    added chrc sourcing to $RCFILE"
    fi
  fi
}

print_done() {
  cat <<EOF

$(printf_bold '==> chrc installed!')

  To use it right now without restarting your shell:
      source "$BIN_PATH"

  Run $(printf_bold 'chrc help') to get started.
  Run $(printf_bold 'chrc new <name>') to create your first profile.
  Run $(printf_bold 'chrc default <name>') to auto-load a profile on shell start.

EOF
}

# --- Entry point -----------------------------------------------------

install_binary
setup_rcfile
print_done
