{ config, pkgs, lib, ... }:

{
  programs.readline.enable = true;
  programs.readline.extraConfig = builtins.readFile ./inputrc;
}
