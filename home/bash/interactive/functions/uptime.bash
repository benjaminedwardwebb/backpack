# Wraps the uptime command from GNU coreutils.
#
# Adds a subcommand, days, that parses the result of the conventional uptime
# command to obtain a string like "up 5 days". If the uptime is less than a
# full day, it will return a string like "up 12:00".
function uptime {
	local -r first_argument="$1"
	local -r __uptime_executable="$(which uptime)"

	function days {
		$__uptime_executable \
			| sed -E 's/.*(up [^,]*),.*/\1/g'
	}

	case "$@" in
		days) days ;;
		*) $__uptime_executable "$@" ;;
	esac
}
