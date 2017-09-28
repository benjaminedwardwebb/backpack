{ config, pkgs, lib, ... }:

{
  # The 22.05 version of home-manager does not yet support extensible shell
  # (es) options, so this configuration directory for es is symlinked into
  # place.
  home.file.".config/es".source =
    config.lib.file.mkOutOfStoreSymlink "/etc/nixos/home/es";
  home.file.".esrc".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/es/esrc";
}
