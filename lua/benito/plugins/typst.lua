return {
  -- (optional) FT-Erkennung/Syntax; Treesitter deckt das meiste ab.
  {
    "kaarmu/typst.vim",
    ft = "typst",
    config = function () end
  },

  {
    "chomosuke/typst-preview.nvim",
    ft = "typst",
    version = "1.*",
    opts = {},  -- lädt & aktualisiert benötigte Binaries automatisch
    keys = {
      { "<leader>tp", "<cmd>TypstPreviewToggle<CR>", desc = "Typst Preview Toggle" },
    },
  },
}
