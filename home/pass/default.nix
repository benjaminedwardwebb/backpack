{ config, pkgs, lib, ... }:

{
  programs.password-store.enable = true;
  programs.password-store.settings = {
    PASSWORD_STORE_DIR = "$XDG_DATA_HOME/pass/password-store";
  };
}
