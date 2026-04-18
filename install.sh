#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

link() {
    local src="$DOTFILES_DIR/$1"
    local dst="$2"

    if [ -L "$dst" ]; then
        local current
        current="$(readlink "$dst")"
        if [ "$current" = "$src" ]; then
            echo "  ok  $dst"
            return
        fi
        echo "  relink  $dst (was -> $current)"
        rm "$dst"
    elif [ -e "$dst" ]; then
        echo "  backup  $dst -> ${dst}.bak"
        mv "$dst" "${dst}.bak"
    else
        mkdir -p "$(dirname "$dst")"
    fi

    ln -s "$src" "$dst"
    echo "  link  $dst -> $src"
}

echo "Installing dotfiles from $DOTFILES_DIR"
echo

# ~/.config symlinks
link fish        "$HOME/.config/fish"
link nvim        "$HOME/.config/nvim"
link kitty       "$HOME/.config/kitty"
link tmux        "$HOME/.config/tmux"
link starship.toml "$HOME/.config/starship.toml"

# Home directory symlinks
link gitconfig       "$HOME/.gitconfig"
link gitignore_global "$HOME/.gitignore_global"

echo
echo "Done. Machine-specific git config goes in ~/.gitconfig.local"
