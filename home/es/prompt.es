# prompt.es
# Defines my prompt for the extensible shell.
#log "executing prompt.bash"

# Variable names are used to make the series of ANSI escape codes required
# to construct a colorful prompt more comprehensible.
#
# I use 8-bit 256 color codes because it matches configuration for vim and the
# output of my custom `colors` command.
#
# See: man es | less -c "prompt"
# See: https://www.strasis.com/documentation/limelight-xe/reference/ecma-48-sgr-codes
# See: https://stackoverflow.com/questions/4842424/list-of-ansi-color-escape-sequences
# See: https://en.wikipedia.org/wiki/ANSI_escape_code
fn set-prompt {
	normal = \033[0\;38\;5\;
	bold = \033[1\;38\;5\;

	deemphasizedForeground = 10m
	foreground = 12m
	accent = 3m
	hyper = 4m
	
	text_style = \033[0\;38\;5\;10m
	lambda = $text_style ^ 𝝺
	period = $text_style ^ .

	process_id_style = \033[1\;38\;5\;3m
	process_id = $process_id_style ^ $pid

	working_directory_style = \033[1\;38\;5\;4m
	working_directory = $working_directory_style ^ `pwd

	command_style = \033[0\;38\;5\;12m

	prompt1 = $lambda ^ ' ' ^ $process_id ^ ' ' ^ $working_directory ^ ' ' ^ $period ^ ' ' ^ $command_style ^ \n
	prompt2 = ''

	prompt=($prompt1 $prompt2)
	return
}

fn main {
	set-prompt
	return
}

main

#log "executed prompt.bash"
