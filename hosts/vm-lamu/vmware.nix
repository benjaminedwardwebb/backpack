# The NixOS vmware module is not supported on aarch64-linux.
#
# However, others have charted a path to a functioning open-vm-tools
# experience.
#
# See: https://github.com/malloc47/config/blob/95c79bb87dc33386f9fc5ad50fe031ee5cb6eaa5/hosts/optum.nix#L21
{ ... }:

{
  virtualisation.vmware.guest.enable = true;

  networking.interfaces.ens160.useDHCP = true;
  disabledModules = [ "virtualisation/vmware-guest.nix" ];
  nixpkgs.config.allowUnsupportedSystem = true;

  imports = [ ./vmware-guest.nix ];

  # Mount vmware shared folders.
  # See: https://github.com/NixOS/nixpkgs/issues/46529#issuecomment-464664142
  fileSystems."/mnt/hgfs" = {
    device = ".host:/";
    fsType = "fuse./run/current-system/sw/bin/vmhgfs-fuse";
    options = [ "umask=22" "uid=1000" "gid=1000" "allow_other" "defaults" "auto_unmount" ];
  };
}
