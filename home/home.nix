{ config, pkgs, lib, ... }:

let
  username = "benjaminedwardwebb";
in
{
  home.username = username;
  home.homeDirectory = "/home/${username}";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Warn when building if the version of home-manager does not match the
  # version of nixpkgs. Such mismatches can cause instability, and enabling
  # this check is recommended (but not the default).
  home.enableNixpkgsReleaseCheck = true;

  imports = [
    ./bash
    ./dircolors
    ./direnv
    ./es
    ./firefox
    ./git
    ./gpg
    ./i3
    ./i3status-rust
    ./info
    ./nix
    ./nixpkgs
    ./readline
    ./systemd
    ./taskwarrior
    ./tmux
    ./wezterm
    ./xdg
  ];

  home.packages = [
    # desktop environment
    pkgs.i3
    pkgs.i3status-rust
    pkgs.dmenu
    pkgs.fira-code
    pkgs.nerdfonts

    # security
    pkgs.gnupg
    pkgs.pass

    # applications
    pkgs.browserpass
    pkgs.es
    pkgs.firefox
    pkgs.gimp
    #pkgs.shotgun # TODO nixpkgs: shotgun does not support aarch64-linux.
    #pkgs.slack # TODO nixpkgs: slack does not support aarch64-linux.
    pkgs.taskwarrior
    pkgs.timewarrior
    pkgs.tmux
    pkgs.vim
    pkgs.vimpager-latest
    pkgs.w3m
    pkgs.weechat
    pkgs.wezterm
    pkgs.zathura

    # command line tools
    pkgs.awscli
    pkgs.bottom
    pkgs.tree
    pkgs.curl
    pkgs.direnv
    pkgs.du-dust
    pkgs.exa
    pkgs.nix-index
    pkgs.fd
    pkgs.feh
    pkgs.gh
    pkgs.git
    pkgs.glab
    pkgs.glow
    pkgs.httpie
    pkgs.inotify-tools
    pkgs.jq
    pkgs.macchina
    pkgs.nailgun
    pkgs.onefetch
    pkgs.pandoc
    #pkgs.polipo # TODO nixpkgs: insecure package.
    pkgs.pre-commit
    pkgs.procs
    pkgs.readline
    pkgs.ripgrep
    pkgs.sd
    pkgs.slop
    pkgs.sqlite
    #pkgs.ssm-session-manager-plugin # TODO nixpkgs: ssm-session-manager-plugin does not support aarch64-linux.
    pkgs.tealdeer
    pkgs.tokei
    pkgs.unixtools.netstat
    pkgs.xclip

    # development
    pkgs.python310
  ];

}
