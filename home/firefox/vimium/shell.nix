{ pkgs ? import <nixpkgs> { } }:

# Use mach-nix to setup the project's python environment for nix-shell.
# See: https://github.com/DavHau/mach-nix
# See: https://nixos.wiki/wiki/Python
# See: https://thomazleite.com/posts/development-with-nix-python/#using-helper-tools
let
  mach-nix = import
    (builtins.fetchGit {
      url = "https://github.com/DavHau/mach-nix";
      ref = "refs/tags/3.5.0";
    })
    { };
  python = mach-nix.mkPython {
    python = "python310";
    requirements = builtins.readFile ./requirements.txt;
    providers = {
      _default = "nixpkgs,sdist,wheel";
    };
  };
in
pkgs.mkShell {
  buildInputs = [
    python
    pkgs.mypy
  ];
  # The mypy static type checker needs to inspect the python interpreter
  # (i.e., python executable) in order to pick up types from third-party
  # libraries.
  #
  # Since this nix expression builds a project-specific python executable
  # with project-specific third-party libraries installed, we pass the
  # python derivation's output path as a shell environment variable, where
  # it can be used to set the python executable to be inspected in mypy's
  # configuration file (e.g., mypy.ini).
  #
  # See: https://mypy.readthedocs.io/en/latest/running_mypy.html#cannot-find-implementation-or-library-stub
  shellHook = ''
    export PYTHON_EXECUTABLE="${python.outPath}"
  '';
}
