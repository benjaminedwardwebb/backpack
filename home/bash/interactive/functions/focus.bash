# Invoke vim in a focus-oriented mode.
function focus {
	local -r args="$@"
	vim -c :Goyo $args
}
