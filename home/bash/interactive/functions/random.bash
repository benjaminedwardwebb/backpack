if dependency head && dependency tr && dependency uuidgen; then
  function random {
	local args="$@"

	local first_argument="$1"

	if [ "$first_argument" == "uuid" ]; then
		uuidgen lower
	else
		local length=$1
		head /dev/urandom | LC_ALL=C tr -dc 'A-Za-z0-9!"#$%&'\''()*+,-./:;<=>?@[\]^_`{|}~' | head -c $length
		echo
	fi
  }
fi
