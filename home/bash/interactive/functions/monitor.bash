# Run xrandr to configure my Studio Display monitor after plugging it in.
# 
# This can probably be replaced by an autorandr configuration in Home-Manager,
# but this works for now.
# See: https://github.com/phillipberndt/autorandr
# See: https://nix-community.github.io/home-manager/options.html#opt-programs.autorandr.enable
function monitor {
	function usage {
		echo "usage: monitor [on|off]"
	}
	case "$@" in
		on) xrandr --output DP-1 --above eDP-1 --auto || return 1 ;;
		off) xrandr --output DP-1 --off || return 1 ;;
		--help|-h) usage ;;
		*) usage ;;
	esac
	return 0
}
