# A simple bash idiom for printing a horizontal line to the terminal that is
# the length of the terminal.
# See: https://wiki.bash-hackers.org/snipplets/print_horizontal_line#a_line_across_the_entire_width_of_the_terminal
if dependency printf && dependency tr; then
	function linebreak {
		printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
	}
else
	function linebreak {
		echo "linebreak command dependencies not available"
	}
fi
