local M = {}

local sources = {
  vim.fn.expand("~/.cache/wal/colors.Xresources"),
  vim.fn.expand("~/.cache/wal/colors-wal.vim"),
}

local fallback = {
  bg = "#1b100f",
  fg = "#b3beb7",
  color0 = "#1b100f",
  color1 = "#af744d",
  color2 = "#748678",
  color3 = "#a48d6a",
  color4 = "#d08a53",
  color5 = "#eea657",
  color6 = "#f3b75a",
  color7 = "#b3beb7",
  color8 = "#7d8580",
  color9 = "#af744d",
  color10 = "#748678",
  color11 = "#a48d6a",
  color12 = "#d08a53",
  color13 = "#eea657",
  color14 = "#f3b75a",
  color15 = "#b3beb7",
}

local idx = { bg = 0, fg = 7, bg2 = 0, bg3 = 0 }
for i = 0, 15 do
  idx["color" .. i] = i
end

local groups = {
  Normal = { fg = "fg", bg = "bg" },
  NormalNC = { link = "Normal" },
  NormalFloat = { fg = "fg", bg = "bg2" },
  FloatBorder = { fg = "color8", bg = "bg2" },
  FloatTitle = { fg = "color5", bg = "bg2", gui = "bold" },
  EndOfBuffer = { fg = "color8" },
  LineNr = { fg = "color8" },
  CursorLineNr = { fg = "color5", gui = "bold" },
  CursorLine = { bg = "bg2" },
  CursorColumn = { bg = "bg2" },
  ColorColumn = { bg = "bg2" },
  WinSeparator = { fg = "color8" },
  VertSplit = { link = "WinSeparator" },
  SignColumn = { fg = "color8", bg = "bg" },
  FoldColumn = { fg = "color8", bg = "bg" },
  Folded = { fg = "color8", bg = "bg2" },
  NonText = { fg = "color8" },
  Whitespace = { link = "NonText" },
  Conceal = { fg = "color8" },
  SpecialKey = { fg = "color1" },
  WinBar = { fg = "fg", bg = "bg" },
  WinBarNC = { fg = "color8", bg = "bg" },
  Pmenu = { fg = "fg", bg = "bg2" },
  PmenuSel = { fg = "color0", bg = "color6", gui = "bold" },
  PmenuSbar = { bg = "bg2" },
  PmenuThumb = { bg = "color8" },
  PmenuKind = { fg = "color8", bg = "bg2" },
  PmenuExtra = { fg = "color8", bg = "bg2" },
  PmenuKindSel = { fg = "color0", bg = "color6" },
  PmenuExtraSel = { fg = "color0", bg = "color6" },
  WildMenu = { fg = "color0", bg = "color6" },
  Visual = { fg = "color0", bg = "color8" },
  VisualNOS = { link = "Visual" },
  MatchParen = { fg = "color0", bg = "color3", gui = "bold" },
  IncSearch = { fg = "color0", bg = "color5" },
  CurSearch = { link = "IncSearch" },
  Search = { fg = "color0", bg = "color3" },
  Substitute = { fg = "fg", bg = "color1" },
  QuickFixLine = { fg = "color5", bg = "bg2", gui = "bold" },
  qfLineNr = { fg = "color8" },
  qfFileName = { fg = "color4" },
  qfSeparator = { fg = "color8" },
  StatusLine = { fg = "color0", bg = "color8" },
  StatusLineNC = { fg = "color8", bg = "bg" },
  StatusLineTerm = { link = "StatusLine" },
  StatusLineTermNC = { link = "StatusLineNC" },
  TabLine = { fg = "color8", bg = "bg" },
  TabLineFill = { fg = "color8", bg = "bg" },
  TabLineSel = { fg = "fg", bg = "bg2", gui = "bold" },
  ModeMsg = { fg = "fg" },
  MsgSeparator = { fg = "color8" },
  MoreMsg = { fg = "color2" },
  WarningMsg = { fg = "color3" },
  ErrorMsg = { fg = "color1", gui = "bold" },
  Question = { fg = "color2" },
  Directory = { fg = "color4" },
  Title = { fg = "color5", gui = "bold" },
  SpellBad = { sp = "color1", gui = "undercurl" },
  SpellCap = { sp = "color3", gui = "undercurl" },
  SpellLocal = { sp = "color2", gui = "undercurl" },
  SpellRare = { sp = "color6", gui = "undercurl" },
  DiffAdd = { fg = "color2" },
  DiffChange = { fg = "color3" },
  DiffDelete = { fg = "color1" },
  DiffText = { fg = "color6", gui = "bold" },
  netrwDir = { fg = "color4" },
  netrwClassify = { fg = "color8" },
  netrwTreebar = { fg = "color8" },
  netrwSymLink = { fg = "color5" },
  netrwExe = { fg = "color6" },

  Comment = { fg = "color8", gui = "italic" },
  Constant = { fg = "color6" },
  String = { fg = "color2" },
  Character = { link = "String" },
  Number = { fg = "color6" },
  Boolean = { link = "Number" },
  Float = { link = "Number" },
  Identifier = { fg = "fg" },
  Function = { fg = "color4" },
  Statement = { fg = "color5" },
  Conditional = { link = "Statement" },
  Repeat = { link = "Statement" },
  Label = { link = "Statement" },
  Operator = { fg = "fg" },
  Keyword = { link = "Statement" },
  Exception = { link = "Statement" },
  PreProc = { fg = "color5" },
  Include = { fg = "color4" },
  Define = { link = "PreProc" },
  Macro = { link = "PreProc" },
  PreCondit = { link = "PreProc" },
  Type = { fg = "color3" },
  StorageClass = { link = "Type" },
  Structure = { link = "Type" },
  Typedef = { link = "Type" },
  Special = { fg = "color1" },
  SpecialChar = { link = "Special" },
  Tag = { fg = "color5" },
  Delimiter = { fg = "fg" },
  SpecialComment = { fg = "color8", gui = "italic" },
  Debug = { fg = "color8" },
  Underlined = { fg = "color5", gui = "underline" },
  Error = { fg = "color1", gui = "bold" },
  Todo = { fg = "color6", gui = "bold" },

  ["@comment"] = { link = "Comment" },
  ["@comment.error"] = { fg = "color1", gui = "bold" },
  ["@comment.warning"] = { fg = "color3", gui = "bold" },
  ["@comment.note"] = { fg = "color2" },
  ["@comment.todo"] = { fg = "color6", gui = "bold" },
  ["@string"] = { link = "String" },
  ["@string.escape"] = { fg = "color3" },
  ["@string.special"] = { fg = "color1" },
  ["@string.regex"] = { fg = "color6" },
  ["@character"] = { link = "Character" },
  ["@character.special"] = { fg = "color1" },
  ["@number"] = { link = "Number" },
  ["@boolean"] = { link = "Boolean" },
  ["@float"] = { link = "Float" },
  ["@constant"] = { fg = "color6" },
  ["@constant.builtin"] = { fg = "color3" },
  ["@constant.macro"] = { fg = "color5" },
  ["@module"] = { fg = "color3" },
  ["@namespace"] = { link = "@module" },
  ["@variable"] = { fg = "fg" },
  ["@variable.builtin"] = { fg = "color3", gui = "italic" },
  ["@variable.parameter"] = { fg = "fg", gui = "italic" },
  ["@variable.parameter.reference"] = { fg = "fg" },
  ["@variable.member"] = { fg = "fg" },
  ["@property"] = { fg = "fg" },
  ["@function"] = { fg = "color4" },
  ["@function.builtin"] = { fg = "color4", gui = "italic" },
  ["@function.call"] = { link = "@function" },
  ["@function.macro"] = { link = "@function" },
  ["@method"] = { link = "@function" },
  ["@method.call"] = { link = "@function" },
  ["@constructor"] = { fg = "color5" },
  ["@keyword"] = { fg = "color5" },
  ["@keyword.conditional"] = { link = "@keyword" },
  ["@keyword.conditional.ternary"] = { link = "@keyword" },
  ["@keyword.repeat"] = { link = "@keyword" },
  ["@keyword.return"] = { link = "@keyword" },
  ["@keyword.function"] = { link = "@keyword" },
  ["@keyword.operator"] = { link = "@keyword" },
  ["@keyword.import"] = { fg = "color4" },
  ["@keyword.exception"] = { link = "@keyword" },
  ["@keyword.storage"] = { link = "@keyword" },
  ["@keyword.directive"] = { fg = "color3" },
  ["@operator"] = { fg = "fg" },
  ["@punctuation.bracket"] = { fg = "fg" },
  ["@punctuation.delimiter"] = { fg = "fg" },
  ["@punctuation.special"] = { fg = "color1" },
  ["@type"] = { link = "Type" },
  ["@type.builtin"] = { link = "Type" },
  ["@type.definition"] = { link = "Type" },
  ["@type.qualifier"] = { fg = "color5" },
  ["@attribute"] = { fg = "color5" },
  ["@label"] = { fg = "color5" },
  ["@symbol"] = { fg = "color6" },
  ["@tag"] = { fg = "color5" },
  ["@tag.attribute"] = { fg = "color3" },
  ["@tag.delimiter"] = { fg = "color8" },
  ["@markup.heading"] = { fg = "color5", gui = "bold" },
  ["@markup.heading.1"] = { fg = "color5", gui = "bold" },
  ["@markup.heading.2"] = { fg = "color4", gui = "bold" },
  ["@markup.heading.3"] = { fg = "color6", gui = "bold" },
  ["@markup.strong"] = { fg = "fg", gui = "bold" },
  ["@markup.italic"] = { fg = "fg", gui = "italic" },
  ["@markup.strikethrough"] = { fg = "fg", gui = "strikethrough" },
  ["@markup.underline"] = { fg = "fg", gui = "underline" },
  ["@markup.link"] = { fg = "color5" },
  ["@markup.link.label"] = { fg = "color4" },
  ["@markup.link.url"] = { fg = "color3", gui = "underline" },
  ["@markup.list"] = { fg = "color5" },
  ["@markup.list.checked"] = { fg = "color2" },
  ["@markup.list.unchecked"] = { fg = "color8" },
  ["@markup.raw"] = { fg = "color2" },
  ["@markup.math"] = { fg = "color6" },
  ["@markup.environment"] = { fg = "color3" },
  ["@markup.environment.name"] = { fg = "color5" },
  ["@markup.quote"] = { fg = "color8", gui = "italic" },
  ["@text.title"] = { link = "@markup.heading" },
  ["@text.literal"] = { link = "@markup.raw" },
  ["@text.uri"] = { link = "@markup.link.url" },
  ["@text.emphasis"] = { fg = "fg", gui = "italic" },
  ["@text.strong"] = { fg = "fg", gui = "bold" },
  ["@text.underline"] = { fg = "fg", gui = "underline" },
  ["@text.strike"] = { fg = "fg", gui = "strikethrough" },
  ["@text.todo"] = { fg = "color6", gui = "bold" },
  ["@text.note"] = { fg = "color2" },
  ["@text.warning"] = { fg = "color3", gui = "bold" },
  ["@text.danger"] = { fg = "color1", gui = "bold" },
  ["@text.reference"] = { fg = "color4" },
  ["@text.quote"] = { fg = "color8", gui = "italic" },
  ["@text.math"] = { fg = "color6" },
  ["@text.environment"] = { fg = "color3" },
  ["@text.environment.name"] = { fg = "color5" },
  ["@diff.plus"] = { fg = "color2" },
  ["@diff.minus"] = { fg = "color1" },
  ["@diff.delta"] = { fg = "color3" },

  ["@lsp.type.class"] = { fg = "color3" },
  ["@lsp.type.enum"] = { fg = "color3" },
  ["@lsp.type.enumMember"] = { fg = "color6" },
  ["@lsp.type.function"] = { fg = "color4" },
  ["@lsp.type.interface"] = { fg = "color3" },
  ["@lsp.type.keyword"] = { fg = "color5" },
  ["@lsp.type.macro"] = { fg = "color5" },
  ["@lsp.type.method"] = { fg = "color4" },
  ["@lsp.type.namespace"] = { fg = "color3" },
  ["@lsp.type.number"] = { fg = "color6" },
  ["@lsp.type.operator"] = { fg = "fg" },
  ["@lsp.type.parameter"] = { fg = "fg", gui = "italic" },
  ["@lsp.type.property"] = { fg = "fg" },
  ["@lsp.type.string"] = { fg = "color2" },
  ["@lsp.type.struct"] = { fg = "color3" },
  ["@lsp.type.type"] = { fg = "color3" },
  ["@lsp.type.typeParameter"] = { fg = "color3" },
  ["@lsp.type.variable"] = { fg = "fg" },
  ["@lsp.typemod.function.defaultLibrary"] = { fg = "color4", gui = "italic" },

  DiagnosticError = { fg = "color1" },
  DiagnosticWarn = { fg = "color3" },
  DiagnosticInfo = { fg = "color2" },
  DiagnosticHint = { fg = "color6" },
  DiagnosticVirtualTextError = { link = "DiagnosticError" },
  DiagnosticVirtualTextWarn = { link = "DiagnosticWarn" },
  DiagnosticVirtualTextInfo = { link = "DiagnosticInfo" },
  DiagnosticVirtualTextHint = { link = "DiagnosticHint" },
  DiagnosticUnderlineError = { sp = "color1", gui = "undercurl" },
  DiagnosticUnderlineWarn = { sp = "color3", gui = "undercurl" },
  DiagnosticUnderlineInfo = { sp = "color2", gui = "undercurl" },
  DiagnosticUnderlineHint = { sp = "color6", gui = "undercurl" },
  DiagnosticSignError = { link = "DiagnosticError" },
  DiagnosticSignWarn = { link = "DiagnosticWarn" },
  DiagnosticSignInfo = { link = "DiagnosticInfo" },
  DiagnosticSignHint = { link = "DiagnosticHint" },
  LspInlayHint = { fg = "color8" },
  LspReferenceText = { bg = "bg3" },
  LspReferenceRead = { bg = "bg3" },
  LspReferenceWrite = { bg = "bg3" },
  LspCodeLens = { fg = "color8" },
  LspCodeLensSeparator = { fg = "color8" },
  LspSignatureActiveParameter = { bg = "bg2", gui = "bold" },

  GitSignsAdd = { fg = "color2" },
  GitSignsChange = { fg = "color3" },
  GitSignsDelete = { fg = "color1" },
  GitSignsCurrentLineBlame = { fg = "color8", gui = "italic" },

  TelescopeNormal = { fg = "fg", bg = "bg" },
  TelescopeBorder = { fg = "color8", bg = "bg" },
  TelescopeTitle = { fg = "color5", gui = "bold" },
  TelescopePromptTitle = { link = "TelescopeTitle" },
  TelescopeResultsTitle = { link = "TelescopeTitle" },
  TelescopePreviewTitle = { link = "TelescopeTitle" },
  TelescopeSelection = { bg = "bg2" },
  TelescopeSelectionCaret = { fg = "color6" },
  TelescopeMatching = { fg = "color6", gui = "bold" },
  TelescopePromptPrefix = { fg = "color4" },

  WhichKey = { fg = "fg" },
  WhichKeyDesc = { fg = "color5" },
  WhichKeyGroup = { fg = "color4" },
  WhichKeyIcon = { fg = "color6" },
  WhichKeySeparator = { fg = "color8" },
  WhichKeyValue = { fg = "color3" },
  WhichKeyBorder = { fg = "color8" },

  CmpItemAbbr = { fg = "fg" },
  CmpItemAbbrDeprecated = { fg = "color8", gui = "strikethrough" },
  CmpItemAbbrMatch = { fg = "color6", gui = "bold" },
  CmpItemAbbrMatchFuzzy = { link = "CmpItemAbbrMatch" },
  CmpItemMenu = { fg = "color8" },
  CmpItemKind = { fg = "color8" },
  CmpItemKindText = { fg = "fg" },
  CmpItemKindMethod = { fg = "color4" },
  CmpItemKindFunction = { fg = "color4" },
  CmpItemKindConstructor = { fg = "color5" },
  CmpItemKindField = { fg = "fg" },
  CmpItemKindVariable = { fg = "fg" },
  CmpItemKindClass = { fg = "color3" },
  CmpItemKindInterface = { fg = "color3" },
  CmpItemKindModule = { fg = "color3" },
  CmpItemKindProperty = { fg = "fg" },
  CmpItemKindUnit = { fg = "color3" },
  CmpItemKindValue = { fg = "color6" },
  CmpItemKindEnum = { fg = "color3" },
  CmpItemKindKeyword = { fg = "color5" },
  CmpItemKindSnippet = { fg = "color2" },
  CmpItemKindColor = { fg = "color5" },
  CmpItemKindFile = { fg = "color4" },
  CmpItemKindReference = { fg = "color3" },
  CmpItemKindFolder = { fg = "color4" },
  CmpItemKindEnumMember = { fg = "color6" },
  CmpItemKindConstant = { fg = "color6" },
  CmpItemKindStruct = { fg = "color3" },
  CmpItemKindEvent = { fg = "color5" },
  CmpItemKindOperator = { fg = "fg" },
  CmpItemKindTypeParameter = { fg = "color3" },

  NoiceCmdline = { fg = "fg" },
  NoiceCmdlineIcon = { fg = "color4" },
  NoiceCmdlinePopupBorder = { fg = "color8" },
  NoiceCmdlinePopupTitle = { fg = "color5" },
  NoicePopupmenu = { fg = "fg", bg = "bg2" },
  NoicePopupmenuBorder = { fg = "color8", bg = "bg2" },
  NoicePopupmenuMatch = { fg = "color6", gui = "bold" },
  NoiceMini = { bg = "bg2" },
  NoiceConfirmBorder = { fg = "color8" },
  NotifyERRORTitle = { fg = "color1" },
  NotifyERRORIcon = { fg = "color1" },
  NotifyERRORBorder = { fg = "color1" },
  NotifyWARNTitle = { fg = "color3" },
  NotifyWARNIcon = { fg = "color3" },
  NotifyWARNBorder = { fg = "color3" },
  NotifyINFOTitle = { fg = "color2" },
  NotifyINFOIcon = { fg = "color2" },
  NotifyINFOBorder = { fg = "color2" },
  NotifyDEBUGTitle = { fg = "color8" },
  NotifyDEBUGIcon = { fg = "color8" },
  NotifyDEBUGBorder = { fg = "color8" },
  NotifyTRACETitle = { fg = "color8" },
  NotifyTRACEIcon = { fg = "color8" },
  NotifyTRACEBorder = { fg = "color8" },
}

local function normalize(value)
  if not value:match("^#") then
    value = "#" .. value
  end
  if #value == 4 then
    value = "#" .. value:sub(2, 2):rep(2) .. value:sub(3, 3):rep(2) .. value:sub(4, 4):rep(2)
  end
  if #value == 7 then
    return value:lower()
  end
end

local function keep(colors, key, value)
  value = normalize(value)
  if not value then
    return
  end
  if key == "background" then
    colors.bg = value
  elseif key == "foreground" then
    colors.fg = value
  else
    local n = key:match("^color(%d+)$")
    if n and tonumber(n) < 16 then
      colors["color" .. tonumber(n)] = value
    end
  end
end

local function parse_xresources(text)
  local colors = {}
  for line in vim.gsplit(text, "\n") do
    local key, value = line:match("^%*%.?([%a]+)%s*:%s*([%#%x]+)")
    if key then
      keep(colors, key, value)
    end
  end
  return colors
end

local function parse_vim_vars(text)
  local colors = {}
  for line in vim.gsplit(text, "\n") do
    local key, value = line:match('^%s*let%s+(%w+)%s*=%s*"([#%x]+)"')
    if key then
      keep(colors, key, value)
    end
  end
  return colors
end

local function read(path, parser)
  if vim.fn.filereadable(path) == 0 then
    return nil
  end
  return parser(table.concat(vim.fn.readfile(path), "\n"))
end

local function complete(colors)
  return colors.bg ~= nil and colors.fg ~= nil and colors.color8 ~= nil
end

function M.mix(a, b, amount)
  local function channel(i)
    local x = tonumber(a:sub(i, i + 1), 16)
    local y = tonumber(b:sub(i, i + 1), 16)
    return math.floor(x + (y - x) * amount + 0.5)
  end
  return ("#%02x%02x%02x"):format(channel(2), channel(4), channel(6))
end

function M.get_colors()
  if M.colors then
    return M.colors
  end

  local candidates = {}
  if vim.fn.executable("xrdb") == 1 then
    local out = vim.fn.system("xrdb -query")
    if vim.v.shell_error == 0 and out ~= "" then
      candidates[#candidates + 1] = parse_xresources(out)
    end
  end
  candidates[#candidates + 1] = read(sources[1], parse_xresources) or {}
  candidates[#candidates + 1] = read(sources[2], parse_vim_vars) or {}

  local colors = {}
  for _, c in ipairs(candidates) do
    for k, v in pairs(c) do
      colors[k] = colors[k] or v
    end
    if complete(colors) then
      break
    end
  end
  colors = vim.tbl_extend("keep", colors, fallback)
  colors.bg2 = M.mix(colors.bg, colors.fg, 0.12)
  colors.bg3 = M.mix(colors.bg, colors.fg, 0.25)
  M.colors = colors
  return colors
end

local function is_light(hex)
  local r = tonumber(hex:sub(2, 3), 16) / 255
  local g = tonumber(hex:sub(4, 5), 16) / 255
  local b = tonumber(hex:sub(6, 7), 16) / 255
  return 0.2126 * r + 0.7152 * g + 0.0722 * b > 0.45
end

function M.load()
  local colors = M.get_colors()

  vim.cmd("highlight clear")
  if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
  end
  vim.o.background = is_light(colors.bg) and "light" or "dark"
  vim.g.colors_name = "xrdb"

  for i = 0, 15 do
    vim.g["terminal_color_" .. i] = colors["color" .. i]
  end
  vim.g.terminal_color_background = colors.bg
  vim.g.terminal_color_foreground = colors.fg

  local function hl(name, spec)
    if spec.link then
      vim.api.nvim_set_hl(0, name, { link = spec.link })
      return
    end
    local opts = {}
    if spec.fg then
      opts.fg = colors[spec.fg]
      opts.ctermfg = idx[spec.fg]
    end
    if spec.bg then
      opts.bg = colors[spec.bg]
      opts.ctermbg = idx[spec.bg]
    end
    if spec.sp then
      opts.sp = colors[spec.sp]
    end
    for _, attr in ipairs(vim.split(spec.gui or "", ",")) do
      if attr ~= "" and attr ~= "NONE" then
        opts[attr] = true
      end
    end
    vim.api.nvim_set_hl(0, name, opts)
  end

  for name, spec in pairs(groups) do
    hl(name, spec)
  end

  M.watch()
end

function M.watch()
  local function stamp()
    local t = 0
    for _, path in ipairs(sources) do
      local ftime = vim.fn.getftime(path)
      if ftime > t then
        t = ftime
      end
    end
    return t
  end

  M.stamp = M.stamp or stamp()
  vim.api.nvim_create_autocmd({ "FocusGained", "VimResume" }, {
    group = vim.api.nvim_create_augroup("benito.xrdb", { clear = true }),
    callback = function()
      local now = stamp()
      if now ~= M.stamp then
        M.stamp = now
        M.colors = nil
        vim.cmd("colorscheme xrdb")
      end
    end,
  })
end

return M
