# A date parsing utility based on GNU's date command.
if dependency date; then
	function date-from {
		local args="$@"

		# TODO find a general solution to system-specific overrides of dependency commands
		local __date
		if dependency __system__date; then
			__date=__system__date
		else 
			__date=$(which date)
		fi
		
		local milliseconds=$(($args / 1000))
		$__date -d "@$milliseconds"
	}
	export -f date-from
fi
