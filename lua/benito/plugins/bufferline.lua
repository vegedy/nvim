return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  opts = function()
    local function color(group, attribute)
      return { highlight = group, attribute = attribute }
    end

    -- Resolve theme highlights on every ColorScheme event, including wal updates.
    local base = vim.g.xrdb_transparent ~= false and "NONE" or color("Normal", "bg")
    local surface = color("CursorLine", "bg")
    local accent = color("FloatTitle", "fg")
    local muted = color("Comment", "fg")
    local highlights = {
      fill = { bg = base },
      background = { fg = muted, bg = base },
      tab = { fg = muted, bg = base },
      tab_selected = { fg = accent, bg = surface, bold = true },
      tab_close = { fg = muted, bg = base },
      trunc_marker = { fg = muted, bg = base },
      indicator_selected = { fg = accent, bg = surface },
    }

    for _, suffix in ipairs({ "", "_visible", "_selected" }) do
      local selected = suffix == "_selected"
      local bg = selected and surface or base
      for _, group in ipairs({ "buffer", "close_button", "duplicate", "modified",
        "diagnostic", "error", "warning", "info", "hint", "error_diagnostic",
        "warning_diagnostic", "info_diagnostic", "hint_diagnostic" }) do
        highlights[group .. suffix] = {
          bg = bg,
          sp = selected and accent or nil,
          underline = selected,
          italic = false,
        }
      end
      highlights["buffer" .. suffix].fg = selected and accent or color("Normal", "fg")
      highlights["buffer" .. suffix].bold = selected
      highlights["close_button" .. suffix].fg = muted
      highlights["modified" .. suffix].fg = color("String", "fg")
      highlights["separator" .. suffix] = { fg = surface, bg = bg }
    end
    highlights.buffer.fg = muted

    return {
      options = {
        mode = "buffers",
        style_preset = require("bufferline").style_preset.no_italic,
        separator_style = "thin",
        indicator = { style = "underline" },
        diagnostics = "nvim_lsp",
        modified_icon = "●",
        show_buffer_close_icons = false,
        show_close_icon = false,
        max_name_length = 24,
        tab_size = 22,
        enforce_regular_tabs = false,
      },
      highlights = highlights,
    }
  end,
}

