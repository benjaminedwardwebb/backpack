# configuration.nix
# A facade configuration file that loads the real one in the hosts directory.
#
# This relies on /etc/hostname.
let
  hostname = with builtins;
    replaceStrings ["\n"] [""] (readFile /etc/hostname);
in
import ./hosts/${hostname}/configuration.nix
