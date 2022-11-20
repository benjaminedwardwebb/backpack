self: super:

let
  nixpkgs = self.pkgs.fetchFromGitHub {
    owner = "benjaminedwardwebb";
    repo = "nixpkgs";
    rev = "dmenu-rs";
    sha256 = "sha256-4U8xZlFVTW8L1kNwAhWFhbnNcK05q5dFfa57VugasL4=";
    #rev = "dmenu-rs-alternative";
    #sha256 = "sha256-HN0gPfLPlSr2fqsVx2hcZEJ2Q5tA5fxRXtg9aq3ow+4=";
  };
in
{
  dmenu-rs = super.callPackage "${nixpkgs}/pkgs/applications/misc/dmenu-rs/default.nix" { };
}
