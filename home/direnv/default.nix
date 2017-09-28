{ config, pkgs, lib, ... }:

# See: https://github.com/nix-community/nix-direnv#installation
{
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
}
