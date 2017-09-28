# prompt.bash
# Defines my shell's prompt.
#
# This is specific to the bash shell. That's just going to be my shell for the
# foreseeable future. I'll have to migrate this if I decide later to adopt zsh
# or fish or some other shell.
log "executing prompt.bash"

# Configuring the bash prompt is not too difficult, but it's certainly not
# intuitive because it relies on ANSI escape codes (or at least the approach
# I've taken here does).
#
# I've tried to use variable names to make the series of ANSI escape codes
# required more comprehensible. For terminal color codes, I simply use a
# variable name that matches the color's number directly so that changing the
# terminal's color palette does not make the variable names incorrect. I
# usually swap the terminal's color codes to change themes so that it affects
# every terminal application equally, rather than have to configure each one
# by itself.
#
# I use 8-bit 256 color codes because it matches configuration for vim and the
# output of my custom `colors` command.
#
# See: man bash | page -c "/PROMPTING"
# See: man bash | page -c "/PS1"
# See: https://www.strasis.com/documentation/limelight-xe/reference/ecma-48-sgr-codes
# See: https://stackoverflow.com/questions/4842424/list-of-ansi-color-escape-sequences
# See: https://en.wikipedia.org/wiki/ANSI_escape_code

function generate_prompt {
	# ANSI color code building blocks.
	local -r escape="\033["

	local -r normal="0" # 22 may be better, as this is technically a reset.
	local -r bold="1"
	local -r faint="2"
	local -r italic="3"
	local -r underline="4"
	local -r slow_blink="5"
	local -r rapid_blink="6"
	local -r reverse="7"

	local -r set_foreground_color="38"
	local -r mode256="5"

	local -r deemphasizedForeground="10"
	local -r foreground="12"
	local -r accent="3"
	local -r hyper="4"
	local -r attention="9"

	# Prompt component building blocks.

	# Change prompt colors if direnv is triggered.
	# See: https://github.com/direnv/direnv/issues/68#issuecomment-419400670
	if [[ -n "$DIRENV_DIFF" ]]; then
		local -r default_style="\[${escape}${normal};${set_foreground_color};${mode256};${attention}m\]"
	else
		local -r default_style="\[${escape}${normal};${set_foreground_color};${mode256};${deemphasizedForeground}m\]"
	fi
	local -r lambda="${default_style}𝝺"
	local -r period="${default_style}."

	local -r process_id_style="\[${escape}${bold};${set_foreground_color};${mode256};${accent}m\]"
	local -r process_id="${process_id_style}$$"

	local -r working_directory_style="\[${escape}${bold};${set_foreground_color};${mode256};${hyper}m\]"
	local -r working_directory="${working_directory_style}\w"

	local -r command_style="\[${escape}${normal};${set_foreground_color};${mode256};${foreground}m\]"

	local -r prompt="$lambda $process_id $working_directory $period $command_style"

	echo "$prompt"
	return 0
}

function set_prompt {
	PS1="$(generate_prompt)"
	PS2=""
	PS3=""
	PS4=""
	return 0
}

# Set the prompt using the PROMPT_COMMAND variable. This allows dynamically
# changes to the prompt's color style based on whether the current working
# directory is a direnv directory or not.
# TODO bash: Consider performance of PROMPT_COMMAND=set_prompt.
PROMPT_COMMAND=set_prompt

log "executed prompt.bash"
