# Invoke vim in a custom, focus-oriented mode.
if dependency vim; then
	function focus {
		local -r args="$@"
		vim -c :Goyo $args
	}
else
	alias focus="page"
fi
