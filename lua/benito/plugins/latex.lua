return {
  {
    "lervag/vimtex",
    ft = { "tex" },
    init = function()
      -- Viewer pro OS (anpassen, falls nötig)
      vim.g.vimtex_view_method =
        (vim.loop.os_uname().sysname == "Windows_NT") and "SumatraPDF" or "zathura"

      -- Latexmk als Backend; Continuous-Mode beim Start von :VimtexCompile
      vim.g.vimtex_compiler_method = "latexmk"
      vim.g.vimtex_compiler_latexmk = { continuous = 1, out_dir = "build" }
    end,
  },
}
