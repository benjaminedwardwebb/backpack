# A "compatibility" overlay that loads overlays defined in my NixOS
# configuration and makes them available to nix command line tools.
# See: https://nixos.wiki/wiki/Overlays#Using_nixpkgs.overlays_from_configuration.nix_as_.3Cnixpkgs-overlays.3E_in_your_NIX_PATH
self: super:

with super.lib;
let
  # Load the system config and get the `nixpkgs.overlays` option
  overlays = (import <nixpkgs/nixos> { }).config.nixpkgs.overlays;
in
# Apply all overlays to the input of the current "main" overlay
foldl' (flip extends) (_: super) overlays self
