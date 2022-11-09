# Adds customizations over the GNU coreutils date command.
#
# Here is a sample of added sub-commands.
#
#	date pt [options]
#	# Displays date in US/Pacific time.
#
# 	date from [timestamp]
# 	# Converts a UNIX nanosecond-precision timestamp into a date.
#
# 	date range [start] [end]
# 	# Prints a range of dates from start to end.
#
# Also, a default format of ISO-8601 with minute-precision is used.
function date {
	local -r __date_executable="$(which date)"

	function __date {
		# Use ISO-8601 at minute-precision as a default format if not format
		# is explicitly set in arguments to the date command.
		if [[ "$@" == *+* ]] || [[ "$@" == "*-I*" ]]; then
			$__date_executable "$@"
		else
			$__date_executable --iso-8601=minutes "$@"
		fi
	}
	function utc {
		TZ="UTC" __date "$@"
	}
	function pt {
		TZ="US/Pacific" __date "$@"
	}
	function et {
		TZ="US/Eastern" __date "$@"
	}
	function from {
		local nanoseconds="$1"
		local milliseconds=$(($nanoseconds / 1000))
		__date -d "@$milliseconds"
	}
	function range {
		local -r start_date="$1"
		local -r end_date="$2"

		local date="${start_date}"
		until [[ ${date} > ${end_date} ]]; do
			echo "${date}"
			# The range sub-command is day-oriented and forces an ISO-8601
			# date format. To generate ranges at different time intervals,
			# other commands like
			#
			# 	hours range [start] [end]
			#
			# can be used instead.
			date=$($__date_executable --iso-8601 --date "${date} + 1 day")
		done
	}

	case "$@" in
		utc*) shift 1; utc "$@" ;;
		pt*) shift 1; pt "$@" ;;
		et*) shift 1; et "$@" ;;
		all)
			# Use ISO-8601 minute-precision with timezone abbreviation.
			utc +"%Y-%m-%dT%H:%M:%S%:z %Z"
			et +"%Y-%m-%dT%H:%M:%S%:z %Z"
			pt +"%Y-%m-%dT%H:%M:%S%:z %Z"
			;;
		from[[:space:]]*) shift 1; from "$@" ;;
		range[[:space:]]*) shift 1; range "$@" ;;
		*) __date "$@" ;;
	esac
}
