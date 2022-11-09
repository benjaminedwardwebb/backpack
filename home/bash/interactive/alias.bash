# alias.bash
# Defines bash aliases.
log "executing alias.bash"

# Alias certain bash language constructs for an interactive shell experience
# that is slightly closer to English.
function not {
  ! $@
}
export -f not
alias unit=":"
alias please="sudo"

# Alias change directory commands for certain frequently used directories.
alias home="cd $HOME"
alias projects="cd $HOME/projects"
alias code="cd $HOME/projects/code"
alias bew="cd $HOME/projects/code/benjaminedwardwebb"

# Alias command line utilities.
alias top="btm"
alias htop="btm"
alias du="dust"
alias cloc="tokei"
alias tldr="tealdeer"
alias hex="hexyl"
alias scan="rustscan"
alias open="xdg-open"

log "sourced alias.bash"
