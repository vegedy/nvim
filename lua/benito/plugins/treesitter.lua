return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    opts = {
      install_dir = vim.fn.stdpath("data") .. "/site",
    },
    config = function(_, opts)
      local treesitter = require("nvim-treesitter")
      treesitter.setup(opts)

      local languages = {
        "lua","vim","bash","python","json","yaml","toml",
        "markdown","markdown_inline","regex","latex","typst","rust","c","cpp",
      }
      if vim.fn.executable("tree-sitter") == 1 then
        treesitter.install(languages)
      end

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("BenitoTreesitter", { clear = true }),
        callback = function(args)
          local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
          if not lang or not vim.list_contains(languages, lang) then
            return
          end
          if vim.treesitter.language.add(lang) then
            vim.treesitter.start(args.buf, lang)
            vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
        desc = "Enable Tree-sitter highlighting and indentation",
      })
    end,
  },
}

