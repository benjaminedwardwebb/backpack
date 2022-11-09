# Replace the first argument with the second argument in all files,
# recursively, in the current directory.
function replace {
	local search="$1"
	local replace="$2"

	function usage {
		echo "usage: replace [old] [new]"
	}
	function __replace {
		grep -RlI --color=never "$search" \
			| xargs sed -i "s/$search/$replace/g"
	}

	case "$@" in
		--help|-h) usage ;;
		*) __replace ;;
	esac
}
