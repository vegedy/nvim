# Copilot instructions for vegedy/nvim

## Quick commands
- Install / sync plugins (headless):
  nvim --headless -c 'lua require("lazy").sync()' -c 'q'
- Update plugins (headless):
  nvim --headless -c 'lua require("lazy").update()' -c 'q'
- Open Neovim interactively and use :Lazy to browse/sync plugins.

Note: This is a Neovim configuration repo; there are no project-specific build, test or lint scripts.

## High-level architecture
- Entry: init.lua bootstraps lazy.nvim and loads `benito.core` and the plugin spec import `benito.plugins`.
- benito.core: small core module that sets global options, keymaps and autocmds. Files: lua/benito/core/{options.lua,keymaps.lua,autocmds.lua}.
- benito.plugins: a directory of plugin modules. Each file in lua/benito/plugins returns one or more lazy.nvim plugin specs (tables). lazy.nvim imports this folder via `spec = { { import = "benito.plugins" } }`.
- lazy-lock.json: pinned plugin versions managed by lazy.nvim.

## Key conventions (repo-specific)
- Module namespace: top-level Lua modules use the `benito.*` namespace (e.g. `benito.core`, `benito.plugins.ui`).
- Plugin files: each file under lua/benito/plugins should return a table (or list of tables) with plugin specs compatible with lazy.nvim. Keep each plugin group's config in its own file (e.g. lsp.lua, telescope.lua, theme.lua).
- Core split: core/init.lua simply requires core.options, core.keymaps and core.autocmds; keep minimal logic in core/init.lua.
- Leader keys: mapleader and maplocalleader are set to space in init.lua.
- LSP & completion: lsp.lua config uses mason + mason-lspconfig to ensure servers and nvim-cmp for completion; update server list there (ensure_installed) when adding languages.
- Conditional builds: when a plugin needs a native build step (e.g. telescope-fzf-native), the module uses `cond` and `build` fields; keep `cond` checks to avoid CI failures on builders without build tools.
- Lazy-loading: plugin modules commonly specify `event`, `cmd`, or `keys` for lazy-loading — follow existing patterns when adding new plugins.

## Files to check when making changes
- init.lua — bootstrapping and plugin import
- lua/benito/core/* — options, keymaps, autocmds
- lua/benito/plugins/* — plugin specs and per-plugin config
- lazy-lock.json — updated automatically by lazy.nvim; commit after plugin changes

If you already have other AI assistant configs (CLAUDE.md, .cursorrules, AGENTS.md, .windsurfrules, CONVENTIONS.md, etc.), consider merging any repo-specific rules into this file.

---

Generated: copilot-instructions for vegedy/nvim
