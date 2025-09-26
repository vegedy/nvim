return {
  {
    "nvim-telescope/telescope.nvim",
    version = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Telescope",
    opts = {
      defaults = { mappings = { i = { ["<C-u>"] = false, ["<C-d>"] = false } } },
      pickers = { find_files = { hidden = true } },
    },
    keys = {
      { "<leader>ff", function() require("telescope.builtin").find_files() end, desc = "Find files" },
      { "<leader>fg", function() require("telescope.builtin").live_grep() end,  desc = "Grep (ripgrep)" },
      { "<leader>fb", function() require("telescope.builtin").buffers() end,    desc = "Buffers" },
    },
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = (vim.fn.executable("make") == 1) and "make" or nil,
    cond  = vim.fn.executable("make") == 1,
    config = function() require("telescope").load_extension("fzf") end,
  },
}
