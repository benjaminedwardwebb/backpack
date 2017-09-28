# A function to check if an array contains a particular element.
__contains() {
	local -n array="$1"
	local containee="$2"

	local element
	for element in "${array[@]}"; do
		if [ "$element" == "$containee" ]; then return 0; fi
	done

	return 1
}
