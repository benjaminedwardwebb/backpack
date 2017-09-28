# configuration.nix
# A facade that loads the real configuration.nix file in the hosts directory.
# TODO hosts: I haven't come up with a good mechanism to load the right file dynamically based on the host. Probably an argument to the install script that simply generates this file.
let
  hostname = "vm-lamu";
in
import ./hosts/${hostname}/configuration.nix
