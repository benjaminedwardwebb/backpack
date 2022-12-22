{ pkgs, lib, options, ... }:

{
  nix.settings = {
    experimental-features = "nix-command flakes";
  };

  # Adds a "compatibility" overlay that itself loads the NixOS overlays to the
  # NIX_PATH. Makes overlays defined here available to nix command line tools.
  # See: https://nixos.wiki/wiki/Overlays#Using_nixpkgs.overlays_from_configuration.nix_as_.3Cnixpkgs-overlays.3E_in_your_NIX_PATH
  nix.nixPath =
    options.nix.nixPath.default ++
    [ "nixpkgs-overlays=/etc/nixos/pkgs/overlays-compat/" ];

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg)
    [
      "slack"
      "ssm-session-manager-plugin"
      "lastpass-password-manager"
    ];

  nixpkgs.config.permittedInsecurePackages = [
    "polipo-1.1.1"
    "python3.9-poetry-1.1.12"
  ];

  # Add the Nix User Repository (NUR) to the available packages.
  nixpkgs.config.packageOverrides = pkgs: {
    nur = import
      (
        builtins.fetchTarball "https://github.com/nix-community/NUR/archive/9d70eeafc6cc2f97c5b769058d12631d74a994e3.tar.gz"
      )
      {
        inherit pkgs;
      };
  };

  nixpkgs.overlays = [
    (import ./dmenu-rs.nix)
    (import ./weechat.nix)
  ];

}
