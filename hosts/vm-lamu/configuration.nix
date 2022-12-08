# configuration.nix
# NixOS configuration for host vm-lamu: a port I've docked at.
#
# This host is a virtual machine that runs on my company-owned laptop.
#
# See: https://en.wikipedia.org/wiki/Lamu_Island
# See: nixos-help
{ config, pkgs, ... }:

{
  # A port I've docked at.
  # See: https://en.wikipedia.org/wiki/Lamu_Island
  networking.hostName = "vm-lamu";

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
    ./vmware.nix
    # See: https://nix-community.github.io/home-manager/index.html#sec-install-nixos-module
    <home-manager/nixos>
    ../../pkgs
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use a linux kernel version that supports aarch64.
  boot.kernelPackages = pkgs.linuxPackages_6_0;

  services.xserver.enable = true;
  services.xserver.autorun = true;
  services.xserver.windowManager.i3.enable = true;
  # Configure 3 modes for the monitor.
  #
  #   - retina      MacBook Pro resolution, 3456x2234, 254 DPI
  #   - compromise  57% of above resolution, 2608x1687, 192 DPI
  #   - debug       Xserver default resolution, 1024x768, 96 DPI
  #
  # The compromise mode scales down the MacBook's huge resolution to one at
  # 192 DPI, and that is less sluggish inside of the VMWare host.
  services.xserver.monitorSection = ''
    ModeLine "retina" 663.35 3456 3736 4120 4784 2234 2235 2238 2311 -HSync +Vsync
    Modeline "compromise" 375.46 2608 2808 3096 3584 1687 1688 1691 1746 -HSync +Vsync
    Modeline "debug" 63.50 1024 1072 1176 1328 768 771 775 798 -HSync +VSync
    Option "DefaultModes" "false"
    Option "PreferredMode" "compromise"
  '';
  services.xserver.dpi = 192;
  environment.variables = {
    XCURSOR_SIZE = "32";
    GDK_SCALE = "2";
    GDK_DPI_SCALE = "0.5";
  };

  programs.dconf.enable = true;

  networking.networkmanager.enable = true;
  # My company-owned laptop can only connect to an internal, corporate time
  # server (and only while on the corporate VPN). Is the hostname of this time
  # server secret? I think it's debatable, but I am erring on the safe side.
  # See: https://security.stackexchange.com/questions/43315/should-a-hostname-ever-be-considered-a-secret
  networking.timeServers = import /etc/secrets/timeServers.nix;
  time.timeZone = "America/New_York";

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
  ];

  # OpenSSH is ALWAYS disabled on this host.
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
  }
  # THERE ARE NO SECRETS STORED IN THIS REPOSITORY.
  // import /etc/secrets/password.nix;

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;
  home-manager.users.benjaminedwardwebb = import ../../home/home.nix;
}
