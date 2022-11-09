# environment.bash
# Sets global bash environment variables.
# TODO bash: What other fundamental environment variables should we set here? We probably want to prefer the defaults in most cases. See: https://unix.stackexchange.com/a/76356/523086

# Export environment variables for preferred applications.
export VISUAL=vim
export EDITOR="$VISUAL"
export BROWSER="firefox"
# TODO Using `page` here caused problems with `man` because it's started in a
# separate shell with `/bin/sh` (I think). We could expose the `page` function
# as an executable maybe to get around this.
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
export PATH="$PATH:$LOCAL_BIN"
