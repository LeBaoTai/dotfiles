#!/bin/bash
# If error, exit immediately
set -e

# Define PATH
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="$HOME/.config"
BACKUP_DIR="$TARGET_DIR/dotfiles_backup_$(date +%Y%m%d_%H%M%S)"

echo "🚀 Installing dotfiles..."

# To ensure that .config folder existed
mkdir -p "$TARGET_DIR"

# List of folder need to be linked
CONFIGS=("alacritty" "fish" "nvim")

shopt -s dotglob
for item in "${CONFIGS[@]}"; do
    src="$DOTFILES_DIR/$item"
    dst="$TARGET_DIR/$item"

    # The config list in dot file or not
    if [ ! -d "$src" ]; then
        echo "⚠️  Cannot find the source folder: $src (skipped)"
        continue
    fi

    # 1. Backup if the config is existing
    if [ -e "$dst" ] && [ ! -L "$dst" ]; then
        echo "📦 Doing backup: $item -> $BACKUP_DIR/"
        mkdir -p "$BACKUP_DIR"
        mv "$dst" "$BACKUP_DIR/"
    # 2. Remove old symlink
    elif [ -L "$dst" ]; then
        echo "🗑️  Remove old link of : $item"
        rm "$dst"
    fi

    # 3. Making symlik
    echo "🔗 Linking: $item"
    ln -s "$src" "$dst"
done
shopt -u dotglob

echo "✅ Done!"
