
-- Treesitter configuration
require('nvim-treesitter.configs').setup {
  ensure_installed = "all",
  sync_install = true,
  ignore_install = { "phpdoc", "verilog", "cmake", "svelte" }, -- List of parsers to ignore installing
  autopairs = {
    enable = true,
  },
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = { "" }, -- list of language that will be disabled
    additional_vim_regex_highlighting = true,
  }
}

require 'nvim-treesitter.install'.compilers = { 'clang' }
require 'nvim-treesitter.install'.prefer_git = false

