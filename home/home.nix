{ config, pkgs, lib, options, specialArgs, modulesPath, nixosConfig, osConfig }:

let
  hostname = "${nixosConfig.networking.hostName}";
  username = "${nixosConfig.users.users.benjaminedwardwebb.name}";
  homeDirectory = "${nixosConfig.users.users.benjaminedwardwebb.home}";
in
{
  home.username = username;
  home.homeDirectory = homeDirectory;

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
    ./packages.nix

    ./bash
    ./dircolors
    ./direnv
    ./firefox
    ./git
    ./gpg
    ./i3
    ./i3status-rust
    ./info
    ./mutt
    ./neovim
    ./readline
    ./systemd
    ./taskwarrior
    ./tmux
    ./wezterm
    ./xdg
    ./zathura

    (
      with builtins;
      let
        hostSpecificConfiguration = /. + "${homeDirectory}/hosts/${hostname}/static/home/home.nix";
        hostSpecificConfigurationExists = pathExists hostSpecificConfiguration;
      in
      if hostSpecificConfigurationExists
      then hostSpecificConfiguration
      else { }
    )
  ];
}
