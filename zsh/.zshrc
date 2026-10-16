# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000          # Đã tăng lên 10,000 để lưu lịch sử tốt hơn
SAVEHIST=10000
setopt appendhistory     # Lưu thêm vào history thay vì ghi đè
setopt sharehistory      # Chia sẻ history giữa các tab đang mở
setopt autocd            # Gõ tên thư mục để CD trực tiếp
# End of lines configured by zsh-newuser-install

# The following lines were added by compinstall
zstyle :compinstall filename '/home/lbt/.zshrc'
autoload -Uz compinit
compinit
# End of lines added by compinstall
#
# ==========================================
# CẤU HÌNH NEOVIM (VI) MODE TRÊN ZSH
# ==========================================

# ==============================================================================
# ĐOẠN CONVERT TỪ FISH CONFIG SANG ZSH CONFIG
# ==============================================================================

### EXPORT VARIABLES ###
export TERM="xterm-256color" # Thiết lập loại terminal

### ALIASES ###
# Điều hướng thư mục (Navigation)
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../../'

# Thay thế lệnh "ls" bằng công cụ "eza"
#alias ll='eza -alh --icons --color=always --group-directories-first' # Định dạng danh sách dài
alias la='eza -a --icons --color=always --group-directories-first'  # Hiển thị tất cả file/thư mục
alias ls='eza -lh --icons --color=always --group-directories-first'  # Danh sách rút gọn thông thường
alias lt='eza -aTh --icons --color=always --group-directories-first' # Hiển thị dạng cây (Tree)
alias l.='eza -a | egrep "^\."'
alias ll='eza -alhi --absolute --icons --color=always --group-directories-first' # Hiển thị inode, số link và đường dẫn tuyệt đối của Symlink

# Lấy thông báo lỗi hệ thống từ journalctl
alias jctl="journalctl -p 3 -xb"

# Mã hóa và kiểm tra chữ ký GPG
alias gpg-check="gpg2 --keyserver-options auto-key-retrieve --verify"
alias gpg-retrieve="gpg2 --keyserver-options auto-key-retrieve --receive-keys"

# Viết tắt cho Systemctl, Neovim, Clear và Docker
alias sys="sudo systemctl"
alias nvi="nvim"
alias cl="clear"
alias dk="docker"
alias em='emacsclient -c -n'
alias rsemacs='pkill -f emacs && emacs --daemon'
alias k='kubectl'

# Khởi chạy Containerlab qua môi trường Docker
alias containerlab='docker run --rm -it --privileged \
    --network host \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v /var/run/netns:/var/run/netns \
    -v /etc/hosts:/etc/hosts \
    -v /var/lib/docker/containers:/var/lib/docker/containers \
    --pid="host" \
    -v "$(pwd)":"$(pwd)" \
    -w "$(pwd)" \
    ghcr.io/srl-labs/clab bash' #
source /home/lbt/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
export KUBECONFIG=~/.kube/config
export PATH="$(go env GOPATH)/bin:$PATH"
