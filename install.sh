#!/usr/bin/env bash
# Install alacritty + zellij + neovim + configs + font on a fresh Linux machine.
# Safe to re-run: skips binaries already at the pinned version, backs up real config dirs.
set -euo pipefail

ALACRITTY_VERSION=0.17.0
ZELLIJ_VERSION=0.46.1
NVIM_VERSION=0.12.6

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BIN="$HOME/.local/bin"
mkdir -p "$BIN" "$HOME/.config" "$HOME/.local/opt"

has_version() { # $1 binary path, $2 version
  [ -x "$1" ] && "$1" --version 2>/dev/null | grep -q "$2"
}

arch() {
  case "$(uname -m)" in
    x86_64) echo x86_64 ;;
    aarch64 | arm64) echo aarch64 ;;
    *) echo "unsupported arch: $(uname -m)" >&2; exit 1 ;;
  esac
}

install_zellij() {
  has_version "$BIN/zellij" "$ZELLIJ_VERSION" && return
  echo "==> zellij $ZELLIJ_VERSION"
  curl -fsSL "https://github.com/zellij-org/zellij/releases/download/v$ZELLIJ_VERSION/zellij-$(arch)-unknown-linux-musl.tar.gz" |
    tar -xz -C "$BIN" zellij
}

install_nvim() {
  has_version "$BIN/nvim" "v$NVIM_VERSION" && return
  echo "==> neovim $NVIM_VERSION"
  local a dir="$HOME/.local/opt/nvim-$NVIM_VERSION"
  a=$(arch); [ "$a" = aarch64 ] && a=arm64
  mkdir -p "$dir"
  curl -fsSL "https://github.com/neovim/neovim/releases/download/v$NVIM_VERSION/nvim-linux-$a.tar.gz" |
    tar -xz -C "$dir" --strip-components=1
  ln -sfn "$dir/bin/nvim" "$BIN/nvim"
}

install_alacritty() {
  has_version "$BIN/alacritty" "$ALACRITTY_VERSION" && return
  echo "==> alacritty $ALACRITTY_VERSION (build from source, takes a few minutes)"
  if ! command -v cargo >/dev/null; then
    echo "   need rust first: curl https://sh.rustup.rs -sSf | sh   then re-run" >&2
    return 1
  fi
  echo "   build deps (Debian/Ubuntu, run once if build fails):"
  echo "   sudo apt install cmake g++ pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3"
  cargo install alacritty --locked --version "$ALACRITTY_VERSION" --root "$HOME/.local"
}

link_config() { # $1 name under ~/.config
  local target="$HOME/.config/$1"
  [ "$(readlink "$target" 2>/dev/null)" = "$DOTFILES/$1" ] && return
  [ -e "$target" ] && mv "$target" "$target.pre-dotfiles.$(date +%s)"
  ln -s "$DOTFILES/$1" "$target"
  echo "==> linked ~/.config/$1"
}

install_fonts() {
  mkdir -p "$HOME/.local/share/fonts"
  cp "$DOTFILES"/fonts/*.ttf "$HOME/.local/share/fonts/"
  command -v fc-cache >/dev/null && fc-cache -f >/dev/null
  echo "==> fonts installed"
}

install_zellij
install_nvim
install_fonts
for c in alacritty zellij nvim; do link_config "$c"; done
ln -sfn "$DOTFILES/bin/dots" "$BIN/dots"
install_alacritty || echo "!! alacritty skipped, see message above"

# rust editor tooling (go/python/node toolchains come from your version manager, e.g. mise)
command -v rustup >/dev/null && rustup component add rust-analyzer clippy rustfmt

case ":$PATH:" in *":$BIN:"*) ;; *) echo "!! add $BIN to PATH in your shell rc" ;; esac
echo "done. open nvim once to let lazy.nvim install plugins."
