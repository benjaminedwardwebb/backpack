# Temporarily installs the zoom video conferencing application and runs it.
function zoom {
	export NIXPKGS_ALLOW_UNFREE=1; nix-shell -p zoom-us --run zoom
}
