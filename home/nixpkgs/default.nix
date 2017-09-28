{ config, pkgs, lib, ... }:

{
  # Allow unfree packages.
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg)
    [
      "slack"
      "ssm-session-manager-plugin"
      "lastpass-password-manager"
    ];

  # Permit insecure packages.
  nixpkgs.config.permittedInsecurePackages = [
    "polipo-1.1.1"
    "python3.9-poetry-1.1.12"
  ];
}
