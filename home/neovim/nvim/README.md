# vim

This is my [vim][1] configuration.

## structure

My configuration is organized by vim manual topic and type of vim command.

The manual specifies certain directories and files in which to configure builtin features like filetype detection, syntax highlighting, and colorschemes.

If the manual doesn't specify a location to configure a feature, I will configure it in a dedicated top-level vimscript file named after the most appropriate `:help` topic for that feature. For example, keys are mapped in `mapping.vim`.

```bash
tree --noreport -L 1
```
```
.
├── ftdetect            detects filetypes
├── init.vim            neovim entrypoint
├── mapping.vim         maps keys to vim commands
├── neovim.lua          loads neovim-only lua configuration
├── options.vim         sets vim options
├── pagerOptions.vim    sets vim options for pager
├── pagerSyntax.vim     highlights syntax for pager
├── README.md           README
├── syntax.vim          highlights syntax
├── variables.vim       sets global variables
├── vimpagerrc          pager entrypoint
└── vimrc               vim entrypoint
```

There are several entrypoints that are used depending on which exact vim-like program is invoked.

  - [`neovim`][2] first loads `init.vim`
  - [`vim`][3] first loads `vimrc`
  - [`vimpager`][4] first loads `vimpagerrc`
  - [`page`][5] first loads `init.vim` (TODO)

These entrypoints simply load other configuration files. To preserve performance when invoking vim as a pager, some configuration is split into `pager`-prefixed files. Only these are loaded by `vimpagerrc`.

I use a lot of plugins to create an [IDE][6]-like experience in vim. They're managed with [`nix`][7].

## install

I use neovim as of 2022.

However, I write most of my configuration in vimscript so that it remains compatible with both neovim and vim.

I use [`nix`][7] to install it, link this directory into place at `~/.config/nvim`, and alias it to `vim`.

[1]: https://en.wikipedia.org/wiki/Vim_(text_editor)
[2]: https://github.com/vim/vim
[3]: https://github.com/neovim/neovim
[4]: https://github.com/rkitover/vimpager
[5]: https://github.com/I60R/page
[6]: https://en.wikipedia.org/wiki/Integrated_development_environment
[7]: https://nixos.org/guides/nix-pills/why-you-should-give-it-a-try.html
