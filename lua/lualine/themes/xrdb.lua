local c = require("benito.xrdb").get_colors()
local base_bg = vim.g.xrdb_transparent ~= false and "NONE" or c.bg

local b = { bg = c.bg2, fg = c.fg }
local base = { bg = base_bg, fg = c.fg }

local theme = {
  normal = {
    a = { bg = c.color2, fg = c.bg, gui = "bold" },
    b = b,
    c = base,
  },
  insert = {
    a = { bg = c.color4, fg = c.bg, gui = "bold" },
    b = b,
    c = base,
  },
  visual = {
    a = { bg = c.color6, fg = c.bg, gui = "bold" },
    b = b,
    c = base,
  },
  replace = {
    a = { bg = c.color1, fg = c.bg, gui = "bold" },
    b = b,
    c = base,
  },
  command = {
    a = { bg = c.color5, fg = c.bg, gui = "bold" },
    b = b,
    c = base,
  },
  inactive = {
    a = { bg = base_bg, fg = c.color8 },
    b = { bg = base_bg, fg = c.color8 },
    c = { bg = base_bg, fg = c.color8 },
  },
}
theme.terminal = theme.command

return theme
