# Runs a bash expression every time a file changes.
# See: https://unix.stackexchange.com/a/24340/523086
function on-change {
	local -r file="$1"
	local -r expr="$2"

	local -r process_id="$$"
	local -r __add_prefix=""

	while true; do
		inotifywait --event modify $file |& sed "s/^/$process_id ⇒ /"
		eval "$expr" |& sed "s/^/$process_id ⇒ /"
	done

	return 0
}

# Evaluates a file as a nix expression every time it changes.
function nix-eval-on-change {
	local -r file="$1"
	on-change $file "nix-instantiate --eval $file"
}
