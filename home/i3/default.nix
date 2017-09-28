{ config, pkgs, lib, ... }:

let
  concatenateFiles = files:
    builtins.concatStringsSep "\n" (map builtins.readFile files);
in
{
  xsession.windowManager.i3.enable = true;
  xsession.windowManager.i3.config.bars = [ ];

  # The order of these files is important, because it affects when variables
  # are defined.
  xsession.windowManager.i3.extraConfig = concatenateFiles [
    ./config
    ./theme
    ./style
    ./workspace
    ./window
    ./launcher
    ./bar
    ./start
  ];
}
