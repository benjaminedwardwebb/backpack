{ config, pkgs, lib, ... }:

# The Home Manager neomutt module did not work for some reason, so we
# construct the config files directly under XDG_CONFIG_HOME.
let
  functions = import ../../lib/functions.nix;
in
{
  xdg.configFile."mutt/muttrc".text = functions.concatenateFiles [
    ./muttrc
    ./bind
    ./color
    ./accounts
  ];
  xdg.configFile."mutt/account.benjaminedwardwebb@gmail.com".source =
    ./. + "/account.benjaminedwardwebb@gmail.com";
}
