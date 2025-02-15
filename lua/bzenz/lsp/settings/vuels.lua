local util = require 'lspconfig.util'

local bin_name = 'vls'
local cmd = { bin_name }

if vim.fn.has 'win32' == 1 then
  cmd = { 'cmd.exe', '/C', bin_name }
end

return {
  default_config = {
    cmd = cmd,
    filetypes = { 'vue' },
    root_dir = util.root_pattern('package.json', 'vue.config.js'),
    init_options = {
      config = {
        vetur = {
          useWorkspaceDependencies = false,
          validation = {
            template = true,
            style = true,
            script = true,
            templateProps = true,
            interpolation = true
          },
          completion = {
            autoImport = true,
            useScaffoldSnippets = true,
            tagCasing = 'kebab',
          },
          format = {
            defaultFormatter = {
              js = 'none',
              ts = 'none',
            },
            defaultFormatterOptions = {},
            scriptInitialIndent = false,
            styleInitialIndent = false,
          },
        },
        css = {},
        html = {
          suggest = {},
        },
        javascript = {
          format = {},
        },
        typescript = {
          format = {},
        },
        emmet = {},
        stylusSupremacy = {},
      },
    },
  },
  docs = {
    description = [[
https://github.com/vuejs/vetur/tree/master/server
Vue language server(vls)
`vue-language-server` can be installed via `npm`:
```sh
npm install -g vls
```
]],
    default_config = {
      root_dir = [[root_pattern("package.json", "vue.config.js")]],
    },
  },
}

