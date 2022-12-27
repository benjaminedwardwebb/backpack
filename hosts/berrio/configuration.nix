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
    ../../pkgs
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.xserver.enable = true;
  services.xserver.autorun = true;
  services.xserver.windowManager.i3.enable = true;

  programs.dconf.enable = true;

  networking.networkmanager.enable = true;
  time.timeZone = "America/New_York";

  # TODO options snd-hda-intel enable=0,1,0
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable touchpad support.
  services.xserver.libinput.enable = true;

  environment.systemPackages = with pkgs; [
    git
    man-pages
    man-pages-posix
    vim
    wget
  ];

  # OpenSSH should always be disabled, except as needed for brief file
  # transfer operations between hosts I manage. Use key-based authentication.
  services.openssh.enable = false;
  services.openssh.passwordAuthentication = false;
  services.openssh.kbdInteractiveAuthentication = false;
  security.sudo.execWheelOnly = true;
  security.sudo.extraConfig = "Defaults  timestamp_timeout=720"; # minutes
  users.mutableUsers = false;
  users.users.benjaminedwardwebb = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    description = "Benjamin Edward Webb";
    # THESE ARE PUBLIC KEYS. THERE ARE NO SECRETS STORED IN THIS REPOSITORY.
    # That said, I still avoid publishing my company-owned public SSH key
    # in case RSA is cracked and proved worthless. I don't expect this to
    # happen soon, but I'm not a cryptographer.
    # See: https://security.stackexchange.com/a/150542
    openssh.authorizedKeys.keys = [
    ] ++ import /etc/secrets/authorizedKeys.nix;
  }
  # THERE ARE NO SECRETS STORED IN THIS REPOSITORY.
  // import /etc/secrets/password.nix;

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;
  home-manager.users.benjaminedwardwebb = import ../../home/home.nix;

  services.cron.enable = true;
  services.cron.systemCronJobs = [
    "0 10 * * 1-5 root /run/current-system/sw/bin/poweroff"
    "0 23 * * 1-5 root /run/current-system/sw/bin/poweroff"
  ];

  documentation.dev.enable = true;
  documentation.man.generateCaches = true;
}
