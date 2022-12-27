# Wrap brightnessctl to control monitor brightness in 10% increments.
function bright {
	case "$@" in
		up) brightnessctl set +10% ;;
		down) brightnessctl set 10%- ;;
	esac
	return 0
}
