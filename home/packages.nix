{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # desktop environment
    dmenu-rs
    fira-code
    i3
    i3status-rust
    nerdfonts

    # security
    gnupg
    pass
    pinentry-gtk2

    # applications
    bluez
    browserpass
    es
    firefox
    gimp
    mutt
    pavucontrol
    shotgun
    taskwarrior
    timewarrior
    tmux
    vim
    vimpager-latest
    w3m
    weechat
    wezterm
    zathura

    # command line tools
    awscli
    bottom
    curl
    direnv
    du-dust
    exa
    fd
    feh
    gh
    git
    glab
    glow
    httpie
    inotify-tools
    jq
    macchina
    nailgun
    nix-index
    onefetch
    pandoc
    pre-commit
    procs
    readline
    ripgrep
    sd
    slop
    sqlite
    tealdeer
    tokei
    tree
    unixtools.netstat
    xclip

    # development
    python310
  ];
}
