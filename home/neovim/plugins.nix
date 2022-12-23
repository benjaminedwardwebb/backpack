{ pkgs, ... }:

# TODO neovim: Add GhostText support. See: https://ghosttext.fregante.com/
# TODO neovim: Add better log highlighting with vim-log-highlighting. See: https://github.com/MTDL9/vim-log-highlighting
with pkgs.vimPlugins;
let
  vim-colors-solarized-patched = vim-colors-solarized.overrideAttrs (attrs: {
    # There is no prior patches attribute in vim-colors-solarized attrs.
    patches = [
      ./0001-swap-terminal-color-code-0-and-8.patch
    ];
  });
in
[
  plenary-nvim

  vim-colors-solarized-patched
  vim-table-mode
  nvim-lspconfig
  goyo-vim
  limelight-vim
  nerdcommenter
  nerdtree
  vim-fugitive
  vim-gh-line
  vim-gitgutter
  vim-tmux-navigator

  # TODO neovim: Language-specific plugins should be loaded per-project via shell.nix, along with their lsp counterpart packages, with some custom, pre-packaged modules.
  nvim-metals
  vim-scala
  rust-vim
  vim-nix
]
