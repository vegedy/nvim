local c = require("benito.xrdb").get_colors()

local b = { bg = c.bg2, fg = c.fg }
local normal = { bg = c.bg, fg = c.fg }

return {
  normal = {
    a = { bg = c.color2, fg = c.bg, gui = "bold" },
    b = b,
    c = normal,
  },
  insert = {
    a = { bg = c.color4, fg = c.bg, gui = "bold" },
    b = b,
    c = normal,
  },
  visual = {
    a = { bg = c.color6, fg = c.bg, gui = "bold" },
    b = b,
    c = normal,
  },
  replace = {
    a = { bg = c.color1, fg = c.bg, gui = "bold" },
    b = b,
    c = normal,
  },
  command = {
    a = { bg = c.color5, fg = c.bg, gui = "bold" },
    b = b,
    c = normal,
  },
  inactive = {
    a = { bg = c.bg, fg = c.color8 },
    b = { bg = c.bg, fg = c.color8 },
    c = { bg = c.bg, fg = c.color8 },
  },
}
