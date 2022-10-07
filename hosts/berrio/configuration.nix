# configuration.nix
# NixOS configuration for host berrio: the smallest and swiftest of the
# convoy.
# See: https://en.wikipedia.org/wiki/S%C3%A3o_Gabriel_(ship)
# See: nixos-help
{ config, pkgs, ... }:

{
  networking.hostName = "berrio";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;

  imports = [
    ./hardware-configuration.nix
    # See: https://nix-community.github.io/home-manager/index.html#sec-install-nixos-module
    <home-manager/nixos>
  ];

  # Add the Nix User Repository (NUR) to the available packages.
  nixpkgs.config.packageOverrides = pkgs: {
    nur = import
      (
        builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz"
      )
      {
        inherit pkgs;
      };
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.xserver.enable = true;
  services.xserver.autorun = true;
  services.xserver.windowManager.i3.enable = true;

  programs.dconf.enable = true;

  networking.networkmanager.enable = true;
  time.timeZone = "America/New_York";

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable touchpad support.
  services.xserver.libinput.enable = true;

  environment.systemPackages = with pkgs; [
    git
    vim
    wget
  ];

  services.openssh.enable = false;
  security.sudo.execWheelOnly = true;
  security.sudo.extraConfig = "Defaults  timestamp_timeout=720"; # minutes
  users.mutableUsers = false;
  users.users.benjaminedwardwebb = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    description = "Benjamin Edward Webb";
  }
  # THERE ARE NO SECRETS STORED IN THIS REPOSITORY.
  // import /etc/password.nix;

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;
  home-manager.users.benjaminedwardwebb = import ../../home/home.nix;
}

