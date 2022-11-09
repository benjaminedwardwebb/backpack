# A wrapper over the util-linux uuidgen command.
#
# Adds subcommands to convert the generated UUIDs to lowercase or uppercase
# characters only. Note the default is lowercase on linux.
function uuidgen {
	local -r __uuidgen="$(which uuidgen)"

	function lower {
		$__uuidgen "$@" | tr 'A-Z' 'a-z'
	}
	function upper {
		$__uuidgen "$@" | tr 'a-z' 'A-Z' 
	}

	case "$@" in
		lower*) shift 1; lower "$@" ;;
		upper*) shift 1; upper "$@" ;;
		*) $__uuidgen "$@" ;;
	esac
}
