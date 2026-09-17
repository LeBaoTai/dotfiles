if status is-interactive
    # Commands to run in interactive sessions can go here
    ### EXPORT ###
    set fish_greeting # Supresses fish's intro message
    set TERM xterm-256color # Sets the terminal type


    ### AUTOCOMPLETE AND HIGHLIGHT COLORS ###
    set fish_color_normal brcyan
    set fish_color_autosuggestion '#7d7d7d'
    set fish_color_command brcyan
    set fish_color_error '#ff6c6b'
    set fish_color_param brcyan

    ### ALIASES ###
    # navigation
    alias ..='cd ..'
    alias ...='cd ../..'
    alias .3='cd ../../..'
    alias .4='cd ../../../..'
    alias .5='cd ../../../../..'

    #dnf

    # changing "ls" to aze
    alias ll='eza -alh --icons --color=always --group-directories-first' # long format
    alias la='eza -a --icons --color=always --group-directories-first' # all files and dirs
    alias ls='eza -lh --icons --color=always --group-directories-first' # normal list
    alias lt='eza -aTh --icons --color=always --group-directories-first' # tree listing
    alias l.='eza -a | egrep "^\."'er

    # get error messages from journalctl
    alias jctl="journalctl -p 3 -xb"

    # gpg encryption
    # verify signature for isos
    alias gpg-check="gpg2 --keyserver-options auto-key-retrieve --verify"
    # receive the key of a developer
    alias gpg-retrieve="gpg2 --keyserver-options auto-key-retrieve --receive-keys"

    # switch between shells
    alias tofish="chsh -s /bin/fish && exec fish"

    # get fastest mirrors
    alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
    alias mirrord="sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"
    alias mirrors="sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist"
    alias mirrora="sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist"

    #systemctl 
    alias sys="sudo systemctl"

    # Editor
    alias nvi="nvim"

    #clear
    alias cl="clear"

    # docker alias
    alias dk="docker"

    # auto start fastfetch 
    #fastfetch
    alias containerlab='docker run --rm -it --privileged \
        --network host \
        -v /var/run/docker.sock:/var/run/docker.sock \
        -v /var/run/netns:/var/run/netns \
        -v /etc/hosts:/etc/hosts \
        -v /var/lib/docker/containers:/var/lib/docker/containers \
        --pid="host" \
        -v $(pwd):$(pwd) \
        -w $(pwd) \
        ghcr.io/srl-labs/clab bash'
end
