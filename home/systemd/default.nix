{ config, pkgs, lib, ... }:

{
  systemd.user.startServices = "sd-switch";
}
