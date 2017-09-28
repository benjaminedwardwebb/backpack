# Adds an "all" command to date that displays all timezones relevant to me.
# TODO add a "data from <timestamp>" parsing subcommand for millis, etc.
# TODO general solution for commands the same name as their dependency
if dependency date; then
	function date {
		local args="$@"

		# TODO find a general solution to system-specific overrides of dependency commands
		local __date
		if dependency __system__date; then
			__date=__system__date
		else 
			__date=$(which date)
		fi
		
		case "$args" in
			all)
				utc
				$__date
				pst
				;;
			from[[:space:]]*)
				shift 1
				args="$@"
				# TODO custom date has a dependency on custom date-from
				date-from $args
				;;
			*)
				$__date $args
				;;
		esac
	}
fi
