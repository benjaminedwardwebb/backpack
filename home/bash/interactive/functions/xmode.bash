# Convenience function to switch modes with xrandr.
#
# Modes defined in my NixOS configuration include "retina" and "debug".
# Usage: xmode [mode]
function xmode {
	local -r mode="$1"
	xrandr --output Virtual-1 --mode "$mode"
	return 0
}
