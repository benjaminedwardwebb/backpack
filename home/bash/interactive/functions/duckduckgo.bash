# A command that formulates search URLs for the duckduckgo search engine.

# TODO Entering the search string as a bash function's arguments presents some
# interesting parsing problems. For example, repeated use of ! seems to repeat
# certain strings because it triggers some kind of bash-ism. Presumably a
# number of other characters also need to be specially escaped. Maybe there's
# not much to do about this.

function duckduckgo {
	local args="$@"
	local number_of_arguments="$#"
	
	local duckduckgo_lite_url="https://lite.duckduckgo.com/lite"

	local url
	if [ $number_of_arguments == 0 ]; then
		url="$duckduckgo_lite_url"
		echo $url
	else
		# Construct a query string that submits the function's arguments as the
		# search terms.
		local query_string
		if dependency urlencode; then
			# If urlencode (gridsite-clients) is installed, try to urlencode it.
			query_string="q=$(urlencode $args)"
		else
			query_string="q=$args"
		fi

		url="$duckduckgo_lite_url?$query_string"
		echo "\"$url\""
	fi
}
