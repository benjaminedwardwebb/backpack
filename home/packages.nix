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

    # editor
    # neovim is enabled in the neovim directory with home-manager.
    page # TODO home: page, a neovim-based pager in rust, has a problem reading man pages.
    vimpager-latest

    # development
    # TODO home: Language-specific tools should be loaded per-project via shell.nix and some custom, pre-packaged modules.
    python310
    metals
    rnix-lsp
    rust-analyzer

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
  ];
}
