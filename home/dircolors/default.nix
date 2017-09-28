{ config, pkgs, lib, ... }:

{
  programs.dircolors.enable = true;
  programs.dircolors.enableBashIntegration = true;
  programs.dircolors.extraConfig = builtins.readFile ./dircolors;
}
