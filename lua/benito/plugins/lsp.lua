return {
  { "neovim/nvim-lspconfig", lazy = false },  -- liefert die Server-Configs
  { "mason-org/mason.nvim",   build = ":MasonUpdate", opts = {} },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "mason-org/mason.nvim", "neovim/nvim-lspconfig" },
    opts = {
      ensure_installed = { "lua_ls","pyright","bashls","jsonls","yamlls","texlab","tinymist" },
      automatic_installation = true,
    },
  },

  -- Completion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp, luasnip = require("cmp"), require("luasnip")
      luasnip.config.setup({})
      cmp.setup({
        snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"]      = cmp.mapping.confirm({ select = true }),
          ["<Tab>"]     = cmp.mapping.select_next_item(),
          ["<S-Tab>"]   = cmp.mapping.select_prev_item(),
          ["<C-J>"]     = cmp.mapping.select_next_item(),
          ["<C-K>"]     = cmp.mapping.select_prev_item(),
        }),
        sources = cmp.config.sources(
          { { name = "nvim_lsp" }, { name = "luasnip" } },
          { { name = "buffer" }, { name = "path" } }
        ),
      })
      local ok, ap = pcall(require, "nvim-autopairs.completion.cmp")
      if ok then cmp.event:on("confirm_done", ap.on_confirm_done()) end
    end,
  },

  -- LSP-Konfiguration (neue API)
  {
    "neovim/nvim-lspconfig",
    init = function()
      vim.diagnostic.config({ virtual_text = false, float = { border = "rounded" } })
    end,
    config = function()
      -- cmp-Fähigkeiten
      local caps = vim.lsp.protocol.make_client_capabilities()
      local ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
      if ok then caps = cmp_lsp.default_capabilities(caps) end

      -- Server-spezifische Settings (vor enable() definieren)
      vim.lsp.config("lua_ls", {
        capabilities = caps,
        settings = { Lua = { diagnostics = { globals = { "vim" } }, workspace = { checkThirdParty = false } } },
      })
      vim.lsp.config("texlab",   { capabilities = caps })
      vim.lsp.config("tinymist", { capabilities = caps }) -- Typst LSP

      for _, name in ipairs({ "lua_ls","pyright","bashls","jsonls","yamlls","texlab","tinymist" }) do
        vim.lsp.enable(name)
      end

      -- On-attach Keymaps (pro Buffer)
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local b = args.buf
          local tb = require("telescope.builtin")
          local map = function(m, lhs, rhs, desc) vim.keymap.set(m, lhs, rhs, { buffer = b, desc = desc }) end
          map("n", "gd", tb.lsp_definitions,      "Definition")
          map("n", "gr", tb.lsp_references,       "Usages")
          map("n", "gI", tb.lsp_implementations,  "Implementationen")
          map("n", "<leader>lr", vim.lsp.buf.rename,      "Rename")
          map("n", "<leader>la", vim.lsp.buf.code_action, "Code Actions")
          map("n", "K",         vim.lsp.buf.hover,        "Hover")
          map("n", "<leader>ld",vim.diagnostic.open_float,"Diagnostics (Cursor)")
        end,
      })
    end,
  },
}
