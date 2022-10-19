# home

This is configuration for the user environment.

It contains applications configuration, i.e., my dotfiles.

## structure

Each directory is the configuration for a different application.

## host-specific configuration

Host-specific user configuration is imported inside `home.nix`.

It's expected to live at at `~/hosts/${hostname}/static/home/home.nix`.

See `./home.nix` and `./xdg/README.md` for more details.
