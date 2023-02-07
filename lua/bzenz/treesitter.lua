
-- Treesitter configuration
require('nvim-treesitter.configs').setup {
  ensure_installed = "all",
  sync_install = false,
  ignore_install = { "" }, -- List of parsers to ignore installing
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = { "" }, -- list of language that will be disabled
    additional_vim_regex_highlighting = true,
  }
}

require 'nvim-treesitter.install'.compilers = { 'zig' }

