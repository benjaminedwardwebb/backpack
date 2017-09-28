{ config, pkgs, lib, ... }:

{
  programs.taskwarrior.enable = true;
  programs.taskwarrior.colorTheme = ./solarized-light-256;
  xdg.configFile."task/hooks".source = ./hooks;
}
