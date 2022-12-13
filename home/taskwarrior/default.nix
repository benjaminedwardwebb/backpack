{ pkgs, ... }:

{
  programs.taskwarrior.enable = true;
  programs.taskwarrior.colorTheme = ./solarized-light-256;
  programs.taskwarrior.extraConfig = builtins.readFile ./taskrc;
  xdg.configFile."task/hooks".source = ./hooks;
}
