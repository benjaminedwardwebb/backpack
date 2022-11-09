{
  programs.zathura.enable = true;
  programs.zathura.extraConfig = builtins.readFile ./zathurarc;
}
