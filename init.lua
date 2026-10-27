vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- lazy.nvim bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

require("benito.core")
require("lazy").setup({
  spec = { { import = "benito.plugins" } },
  change_detection = { notify = false },
})

local config_dir = vim.fn.stdpath("config") .. "/lua/benito/config"
local config_files = vim.fn.globpath(config_dir, "**/*.lua", false, true)
table.sort(config_files)

for _, file in ipairs(config_files) do
  local module = "benito.config." .. file:sub(#config_dir + 2)
    :gsub("%.lua$", "")
    :gsub("/", ".")
  module = module:gsub("%.init$", "")
  require(module).setup()
end
