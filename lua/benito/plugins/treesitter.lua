return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      ensure_installed = {
        "lua","vim","bash","python","json","yaml","toml",
        "markdown","markdown_inline","regex","latex","typst","rust","c","cpp",
      },
      highlight = { enable = true },
      indent    = { enable = true },
    },
    config = function(_, opts) require("nvim-treesitter.configs").setup(opts) end,
  },
}

