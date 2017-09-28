# A function to compile nix files on changes.
if dependency nix && dependency inotifywait; then
	function nixate {
		local -r file="$1"
		while true; do
			inotifywait --event modify $file
			nix-instantiate --eval $file
		done
	}
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
fi
