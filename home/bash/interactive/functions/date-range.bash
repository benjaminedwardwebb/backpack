# A date parsing utility based on GNU's date command.
if dependency date; then
	function date-range {
		local -r start_date="$1"
		local -r end_date="$2"

		# TODO find a general solution to system-specific overrides of dependency commands
		if dependency __system__date; then
			local -r __date="__system__date"
		else 
			local -r __date=$(which date)
		fi
		
		local date="${start_date}"
		until [[ ${date} > ${end_date} ]]; do
			echo "${date}"
			date=$($__date -I -d "${date} + 1 day")
		done
	}
	export -f date-range
fi
