{ config, pkgs, lib, ... }:

{
  # The 22.05 version of home-manager does not yet support wezterm options,
  # but options do exist in the main branch. Once these options are available
  # in a release (likely 22.10), these options can be uncommented and the
  # symlink workaround can be removed.
  #programs.wezterm.enable = true;
  #programs.wezterm.extraConfig = builtins.readFile ./wezterm.lua;

  home.file.".config/wezterm".source =
    config.lib.file.mkOutOfStoreSymlink "/etc/nixos/home/wezterm";
}
