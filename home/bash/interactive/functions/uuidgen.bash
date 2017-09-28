# uuidgen helpers
if dependency uuidgen && dependency tr; then
	function uuidgen {
		local args="$@"

		local first_argument="$1"

		local __uuidgen="$(which uuidgen)"

		if [ "$first_argument" == "lower" ]; then
			$__uuidgen | tr 'A-Z' 'a-z'
		else
			$__uuidgen $args
		fi
	}
fi
