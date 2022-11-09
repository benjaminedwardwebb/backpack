# A wrapper over the glow command.
#
# Enforces style (light or dark mode) and automatically pages when glow is
# called directly on a markdown file.
function glow {
	local -r __glow_executable="$(which glow)"

	# Eventually this style parameter should be injected by nix to switch
	# between light and dark modes.
    local -r style="light"

	case "$@" in
		*.md) $__glow_executable -s $style "$@" | less -r ;;
		*) $__glow_executable -s $style "$@" ;;
	esac
}
