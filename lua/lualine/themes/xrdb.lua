local c = require("benito.xrdb").get_colors()

local b = { bg = c.bg2, fg = c.fg }
local base = { bg = c.bg, fg = c.fg }

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
    a = { bg = c.bg, fg = c.color8 },
    b = { bg = c.bg, fg = c.color8 },
    c = { bg = c.bg, fg = c.color8 },
  },
}
theme.terminal = theme.command

return theme
