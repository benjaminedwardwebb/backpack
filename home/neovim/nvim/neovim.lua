-- neovim.lua
-- Configure neovim with lua.
--
-- My vim configuration is in vimscript so that it is compatible with both
-- vim and neovim. However, some things are significantly easier to configure
-- in lua.
local lspconfig = require "lspconfig"
-- The lspconfig for metals is intentionally left out. See: https://github.com/scalameta/nvim-metals#installation
lspconfig.rnix.setup{}
lspconfig.rust_analyzer.setup{}
