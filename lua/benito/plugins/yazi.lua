return {
  {
    "mikavilpas/yazi.nvim",
    version = "*",
    event = "VeryLazy",
    keys = {
      { "<leader>-",  "<cmd>Yazi<cr>",      desc = "Yazi: hier" },
      { "<leader>fy", "<cmd>Yazi cwd<cr>",  desc = "Yazi: cwd" },
      { "<leader>fy",     "<cmd>Yazi toggle<cr>", desc = "Yazi: Resume" },
    },
    opts = { open_for_directories = false },
    init = function() vim.g.loaded_netrwPlugin = 1 end,
  },
}
