self: super:

# I added dmenu-rs to nixpkgs.
#
# However, it's not been released as part of a channel yet. This overlay adds
# the dmenu-rs package from the commit of nixpkgs in which I added it.
#
# See: https://github.com/NixOS/nixpkgs/commit/84edcb0b64af62ff323df2ed19daf3507415b633
let
  nixpkgs = self.pkgs.fetchFromGitHub {
    owner = "NixOS";
    repo = "nixpkgs";
    rev = "84edcb0b64af62ff323df2ed19daf3507415b633";
    sha256 = "sha256-1KCxJqPpWTNf2nlao9asGWvLyOBSa9h0UZ+uEsRkSaY=";
  };
in
{
  dmenu-rs = super.callPackage "${nixpkgs}/pkgs/applications/misc/dmenu-rs/default.nix" { };
}
