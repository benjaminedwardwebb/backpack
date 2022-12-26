# environment.bash
# Sets global bash environment variables.
# See: https://unix.stackexchange.com/a/76356/523086

# Export environment variables for preferred applications.
export VISUAL=vim
export EDITOR="$VISUAL"
export BROWSER="firefox"
# TODO bash: Use page, the neovim-based pager written in rust, as PAGER once a version without the man pager bug is available in nixpkgs. See: https://github.com/I60R/page/issues/37
export PAGER="vimpager"

# Export environment variables for important directories.
export BACKPACK="/etc/nixos"
export LOCAL_BIN="$HOME/.local/bin"
export PROJECTS="$HOME/projects"
export CODE="$PROJECTS/code"
export BEW="$CODE/benjaminedwardwebb"

# Export other environment variables.
export DIRENV_LOG_FORMAT=""

# Export PATH environment variable.
add-to-path() {
	local -r directory="$1"
	if [ -d "${directory}" ] && [[ ":$PATH:" != *":${directory}:"* ]]; then
		PATH="${PATH:+"$PATH:"}$directory"
	fi
}
add-to-path "$LOCAL_BIN"
