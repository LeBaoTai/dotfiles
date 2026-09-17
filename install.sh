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

    # Kiểm tra xem thư mục nguồn có tồn tại trong repo dotfiles không
    if [ ! -d "$src" ]; then
        echo "⚠️  Cannot find the source folder: $src (skipped)"
        continue
    fi

    # 1. Nếu đích đến đã tồn tại và là file/thư mục thật (không phải symlink) -> Tiến hành backup
    if [ -e "$dst" ] && [ ! -L "$dst" ]; then
        echo "📦 Doing backup: $item -> $BACKUP_DIR/"
        mkdir -p "$BACKUP_DIR"
        mv "$dst" "$BACKUP_DIR/"
    # 2. Nếu đích đến đã là một symlink cũ -> Xóa symlink cũ để ghi đè link mới
    elif [ -L "$dst" ]; then
        echo "🗑️  Remove old link of : $item"
        rm "$dst"
    fi

    # 3. Tạo liên kết tượng trưng (symlink)
    echo "🔗 Linking: $item"
    ln -s "$src" "$dst"
done
shopt -u dotglob

echo "✅ Done!"
