{ pkgs, ... }:

{
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

  nixpkgs.overlays = [
    (import ./dmenu-rs.nix)
    (import ./weechat.nix)
  ];
}
