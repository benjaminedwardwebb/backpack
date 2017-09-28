# My custom commands over nix.
if dependency nix; then
	function nix {
		local -r args="$@"
		local -r __nix=$(which nix)
		if [ "$args" = "generations" ]; then
			nix-env --list-generations
		else
			"$__nix" $args
		fi
	}
fi
