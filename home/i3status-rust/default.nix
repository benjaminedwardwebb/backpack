{ config, pkgs, lib, ... }:

{
  programs.i3status-rust.enable = true;
  programs.i3status-rust.bars.top.settings =
    with builtins;
    fromTOML (readFile ./config.toml);
}
