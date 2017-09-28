# A command that brings up my preferred styleguide for various languages.
function style {
	local first_argument="$1"

	local language="$first_argument"

	case $language in
		bash)
			w3m https://google.github.io/styleguide/shellguide.html
			;;
		*) 
			echo "no preferred style guide for $language"
			;;
	esac
}
