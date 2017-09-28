{ config, pkgs, lib, ... }:

{
  # Enable GNU info.
  # See: https://nix-community.github.io/home-manager/options.html#opt-programs.info.enable
  programs.info.enable = true;
}
