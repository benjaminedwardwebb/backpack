# Wraps the bc command with friendly usage.
function calc {
	local -r args="$@"
	local -r number_of_arguments="$#"

	local -r __bc=$(which bc)
	local -r bc_init_file="/tmp/bc_init"

	echo "scale=10;" > $bc_init_file

	if [ $number_of_arguments == 0 ]; then
		$__bc -i -q $bc_init_file
	else
		echo "scale=10; $args" | $__bc -q
	fi
}
