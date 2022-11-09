# A convenience function for generating random data.
# See: random --help
function random {
	function usage {
		echo "usage: random uuid"
		echo "   or: random ascii [length]"
		echo ""
		echo "The default length random ascii data is 16."
	}
	function ascii {
		local -r length="${1:-16}"
		head /dev/urandom \
			| LC_ALL=C tr -dc 'A-Za-z0-9!"#$%&'\''()*+,-./:;<=>?@[\]^_`{|}~' \
			| head -c $length
		echo
	}

	case "$@" in
		uuid) uuidgen lower ;;
		ascii*) shift 1; ascii "$@" ;;
		--help|-h) usage ;;
	esac
}
