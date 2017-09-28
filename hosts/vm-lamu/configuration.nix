# configuration.nix
# NixOS configuration for host vm-lamu, or Lamu, for short: a port
# I've docked at.
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

  # Use linux kernel version 5.19.
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_5_19;

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

  # Use Apple's time server to match the system hosting the virtual machine.
  networking.timeServers = [ "time.apple.com" ];
  # Keep default time zone UTC. System time is synchronized to local time
  # already and setting the time zone offsets the time twice. Using no offset
  # gives accurate local time. Clearly something strange is happening.
  # TODO vm-Lamu: Fix the issue where setting a time zone doubles the offset.
  #time.timeZone = "America/New_York";

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
  ];

  # Setting mutableUsers to true to allow passwords to be set with passwd. I
  # may be able to amend this by using the passwordFile option.
  users.mutableUsers = true;
  users.users.benjaminedwardwebb = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    description = "Benjamin Edward Webb";
  };

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;
  home-manager.users.benjaminedwardwebb = import ../../home/home.nix;
}
