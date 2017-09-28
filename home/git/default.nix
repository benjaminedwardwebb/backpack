{ config, pkgs, lib, ... }:

# TODO git: consider https://deepsource.io/blog/managing-different-git-profiles/
{
  programs.git.enable = true;

  # While git has an extraConfig setting that accepts a string, it is
  # deprecated. Instead we create the config file directly.
  # See: https://nix-community.github.io/home-manager/options.html#opt-programs.git.extraConfig
  # See: https://github.com/nix-community/home-manager/commit/a28614e65d2ff0e78fe54ca6ec31cc042f563669
  xdg.configFile."git/config".source = ./config;

  # We follow a similar approach on the above for git's ignore file.
  xdg.configFile."git/ignore".source = ./ignore;
}
