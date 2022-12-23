{ pkgs, ... }:

{
  programs.neovim.enable = true;
  programs.neovim.vimAlias = true;
  xdg.configFile."nvim".source = ./nvim;
  programs.neovim.plugins = import ./plugins.nix { pkgs = pkgs; };
}
