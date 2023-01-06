local c = require('gh.colors')

return {
  Cursor = { fg = c.bg_0, bg = c.fg_1 }, -- character under the cursor
  CursorLine = { bg = c.bg_1 }, -- vertical line under cursor

  LineNr = { fg = c.fg_2 }, -- gutter line numbers
  CursorLineNr = { bg = c.bg_1 }, -- gutter line number for current line
  ColorColumn = { bg = c.bg_1 }, -- columns set with 'colorcolumn'
  SignColumn = { fg = c.fg_2 }, -- gutter column showing signs

  StatusLine = { fg = c.fg_1, bg = c.bg_1 }, -- status line of current window
  StatusLineNC = { fg = c.fg_2, bg = c.bg_1 }, -- status line of non-current window
  ModeMsg = { fg = c.fg_1 }, -- mode message (-- INSERT --)
  MsgArea = { fg = c.fg_1 }, -- area for messages and cmdline
  MoreMsg = { fg = c.fg_1 }, -- text for pager prompt
  Question = { fg = c.blue_1 }, -- prompts to continue with Enter or yes/no
  Title = { fg = c.fg_1, bg = nil, bold = true }, -- titles from cmdline output
  ErrorMsg = { fg = c.red_1 }, -- command line error messages
  WarningMsg = { fg = c.brown_1 }, -- warning messages
  WildMenu = { fg = c.fg_1, bg = c.yellow_2 }, -- current match in wildmenu completion

  TabLine = { bg = c.bg_0 }, -- tab line
  TabLineFill = { bg = c.bg_0 }, -- tab line outside tabs
  TabLineSel = { bg = c.bg_2 }, -- tabline, current buffer

  VertSplit = { fg = c.bg_2 }, -- column separating vertical splits

  Normal = { fg = c.fg_1, bg = c.bg_0 }, -- normal text
  NormalNC = { fg = c.fg_1, bg = c.bg_0 }, -- normal text in non-current windows
  NormalFloat = { bg = c.bg_0 }, -- normal text in floating windows
  NonText = { fg = c.fg_2 }, -- chars after buffer content and counter in Telescope

  IncSearch = { bg = c.yellow_1 }, -- incremental search
  Search = { bg = c.yellow_2 }, -- last search pattern
  MatchParen = { bg = c.yellow_2 }, -- current and matching bracket
  Visual = { bg = c.yellow_2 }, -- visual mode selection
  Whitespace = { fg = c.fg_2 }, -- whitespace (with 'listchars')
  Conceal = { fg = c.fg_1 }, -- placeholder chars substituted for concealed text
  SpecialKey = { fg = c.fg_1 }, -- unprintable characters

  SpellBad = { sp = c.red_1, undercurl = true },
  SpellCap = { sp = c.brown_1, undercurl = true },
  SpellLocal = { sp = c.blue_1, undercurl = true },
  SpellRare = { sp = c.fg_2, undercurl = true },

  Directory = { fg = c.blue_1 }, -- directory names in listings

  Folded = { bg = c.bg_1 }, -- line for closed folds

  PMenu = { bg = c.bg_1 }, -- popup menu, normal item
  PMenuSel = { bg = c.yellow_2 }, -- popup menu, selected item
  PMenuSbar = { bg = c.bg_2 }, -- popup menu, scrollbar
  PMenuThumb = { bg = c.fg_2 }, -- popup menu, scrollbar indicator

  Error = { fg = c.red_1 }, -- erroneous constructs

  DiffAdd = { bg = c.green_bg },
  DiffChange = { bg = c.yellow_2 },
  DiffDelete = { bg = c.red_bg },
  DiffText = { bg = c.yellow_3, sp = c.blue_1, undercurl = true },

  DiffAdded = { link = 'DiffAdd' },
  DiffRemoved = { link = 'DiffDelete' },
  DiffFile = { fg = c.blue_1 },
  DiffNewFile = { fg = c.green_1 },
  DiffLine = { fg = c.purple_1 },
}
