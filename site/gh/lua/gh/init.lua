vim.cmd('hi clear')
if vim.fn.exists('syntax_on') then
  vim.cmd('syntax reset')
end

vim.o.termguicolors = true
vim.g.colors_name = 'gh'

local hl = function(group, fg, bg, style, sp)
  local n = 'NONE'

  if not style then
    style = n
  end
  if not fg then
    fg = n
  end
  if not bg then
    bg = n
  end
  if not sp then
    sp = n
  end

  local buf = {
    'highlight',
    group,
    'gui=' .. style,
    'guifg=' .. fg,
    'guibg=' .. bg,
    'guisp=' .. sp,
  }
  vim.cmd(table.concat(buf, ' '))
end

local li = function(group, link)
  vim.cmd('highlight! link ' .. group .. ' ' .. link)
end

local c = {
  fg_1 = '#24292f',
  fg_2 = '#6e7781',
  bg_0 = '#ffffff',
  bg_1 = '#f6f8fa',
  bg_2 = '#d0d7de',

  red_1 = '#cf222e',
  red_bg = '#ffd7d5',
  green_1 = '#116329',
  green_bg = '#ccffd8',
  blue_0 = '#0a3069',
  blue_1 = '#0550ae',
  brown_1 = '#953800',
  brown_2 = '#bf8700',
  purple_1 = '#8250df',
  yellow_1 = '#ebddb5',
  yellow_2 = '#fff8c5',
}

--
-- Editor
--

hl('Cursor', nil, c.fg_1) -- character under the cursor
hl('CursorLine', nil, c.bg_1) -- vertical line under cursor

hl('LineNr', c.fg_2) -- gutter line numbers
hl('CursorLineNr', nil, c.bg_1) -- gutter line number for current line
hl('ColorColumn', nil, c.bg_1) -- columns set with 'colorcolumn'
hl('SignColumn', c.fg_2) -- gutter column showing signs

hl('StatusLine', c.fg_1, c.bg_1) -- status line of current window
hl('StatusLineNC', c.fg_2, c.bg_1) -- status line of non-current window
hl('ModeMsg', c.fg_1) -- mode message (-- INSERT --)
hl('MsgArea', c.fg_1) -- area for messages and cmdline
hl('MoreMsg', c.fg_1) -- text for pager prompt
hl('Question', c.blue_1) -- prompts to continue with Enter or yes/no
hl('Title', c.fg_1, nil, 'bold') -- tites from cmdline output
hl('ErrorMsg', c.red_1) -- command line error messages
hl('WarningMsg', c.brown_1) -- warning messages
hl('WildMenu', c.fg_1, c.yellow_2) -- current match in wildmenu completion

hl('TabLine') -- tab line
hl('TabLineFill') -- tab line outside tabs
hl('TabLineSel', nil, c.bg_2) -- tabline, current buffer

hl('VertSplit', c.bg_2) -- column seperating vertical splits

hl('Normal', c.fg_1, c.bg_0) -- normal text
hl('NormalNC', c.fg_1, c.bg_0) -- normal text in non-current windows
hl('NormalFloat', nil, c.bg_1) -- normal text in floating windows
hl('NonText', c.fg_2) -- chars after buffer content and counter in Telescope

hl('IncSearch', nil, c.yellow_1) -- incremental search
hl('Search', nil, c.yellow_2) -- last search pattern
hl('MatchParen', nil, c.yellow_2) -- current and matching bracket
hl('Visual', nil, c.yellow_2) -- visual mode selection
hl('Whitespace', c.fg_2) -- whitespace (with 'listchars')

hl('Directory', c.blue_1) -- directory names in listsings

hl('Folded', nil, c.bg_1) -- line for closed folds

hl('PMenu', nil, c.bg_1) -- popup menu, normal item
hl('PMenuSel', nil, c.yellow_2) -- popup menu, selected item
hl('PMenuSbar', nil, c.bg_2) -- popup menu, scrollbar
hl('PMenuThumb', nil, c.fg_2) -- popup menu, scrollbar indicator

--
-- Treesitter
--

hl('@variable', c.fg_1)
hl('@field', c.fg_1)
hl('@property', c.blue_1)
hl('@label', c.fg_1)

hl('@type', c.brown_1)
hl('@type.definition', c.brown_1)
hl('@type.builtin', c.fg_1)
hl('@attribute', c.purple_1)
hl('@constant', c.brown_1)
hl('@constant.builtin', c.blue_1)
hl('@constant.macro', c.red_1)

hl('@include', c.red_1)
hl('@keyword', c.red_1)
hl('@keyword.operator', c.blue_1)
hl('@operator', c.blue_1)
hl('@conditional', c.red_1)
hl('@repeat', c.red_1)
hl('@exception', c.red_1)
-- Shebang and c preprocessor, style for the former:
li('@preproc', '@comment')
-- c #define:
hl('@define', c.red_1)

hl('@method', c.purple_1)
hl('@method.call', c.purple_1)
hl('@function', c.purple_1)
hl('@function.builtin', c.purple_1)
hl('@function.call', c.purple_1)
-- c preprocessor function name:
hl('@function.macro', c.purple_1)
hl('@parameter', c.fg_1)
hl('@constructor', c.brown_1)
-- go package identifier and rust use identifier:
hl('@namespace', c.fg_1)
-- c extern/static/auto/register/inline:
hl('@storageclass', c.red_1)

hl('@number', c.blue_1)
hl('@float', c.blue_1)
hl('@string', c.blue_0)
hl('@string.escape', c.blue_0)
-- vim help keycode, toml dates:
hl('@string.special', c.purple_1)
hl('@character', c.blue_0)
hl('@character.special', c.red_1)
hl('@boolean', c.blue_1)

hl('@punctuation.bracket', c.fg_1)
hl('@punctuation.special', c.fg_1)
hl('@punctuation.delimiter', c.fg_1)

hl('@comment', c.fg_2, nil, 'italic')

hl('@text.todo', c.fg_2, nil, 'bold')
hl('@text.todo.unchecked', c.fg_2)
hl('@text.todo.checked', c.fg_2)
hl('@text.todo.pending', c.green_1)
hl('@text.todo.moved', c.purple_1)
hl('@text.title', c.blue_1, nil, 'bold')
hl('@text.literal', c.blue_1)
hl('@text.strong', nil, nil, 'bold')
hl('@text.emphasis', nil, nil, 'italic')
hl('@text.reference', c.purple_1)
hl('@text.uri', c.blue_1)

hl('@tag', c.green_1)

hl('@text.diff.add', nil, c.green_bg)
hl('@text.diff.delete', nil, c.red_bg)

-- Currently unused in nvim highlights:
-- @class
-- @debug
-- @decorator
-- @enum
-- @enumMember
-- @event
-- @interface
-- @macro
-- @modifier
-- @punctuation
-- @regexp
-- @struct

-- Diff

hl('DiffAdd', nil, c.green_bg)
hl('DiffChange', nil, c.yellow_2)
hl('DiffDelete', nil, c.red_bg)
hl('DiffText', nil, c.yellow_3, 'undercurl', c.blue_1)

li('DiffAdded', 'DiffAdd')
li('DiffRemoved', 'DiffDelete')
hl('DiffFile', c.blue_1)
hl('DiffNewFile', c.green_1)
hl('DiffLine', c.purple_1)

--
-- TODO: LSP
--

-- li('LspReferenceText', 'CursorLine')
-- li('LspReferenceRead', 'CursorLine')
-- li('LspReferenceWrite', 'CursorLine')

-- hl('LspDiagnosticsDefaultError', c.red_1)
-- hl('LspDiagnosticsUnderlineError', nil, nil, 'underline', c.red_1)
-- hl('LspDiagnosticsVirtualTextError', c.red_1, c.red_3)
-- hl('LspDiagnosticsDefaultWarning', c.orange_1)
-- hl('LspDiagnosticsUnderlineWarning', nil, nil, 'underline', c.orange_1)
-- hl('LspDiagnosticsVirtualTextWarning', c.orange_1, c.yellow_3)
-- hl('LspDiagnosticsDefaultInformation', c.blue_1)
-- hl('LspDiagnosticsUnderlineInformation', nil, nil, 'underline', c.blue_1)
-- hl('LspDiagnosticsVirtualTextInformation', c.blue_1, c.blue_3)
-- hl('LspDiagnosticsDefaultHint', c.green_1)
-- hl('LspDiagnosticsUnderlineHint', nil, nil, 'underline', c.green_1)
-- hl('LspDiagnosticsVirtualTextHint', c.green_1, c.green_3)

--
-- Telescope
--

hl('TelescopeBorder', c.bg_2)
hl('TelescopeMatching', c.red_1)
hl('TelescopePromptPrefix', c.fg_1)

--
-- Gitsigns
--

hl('GitSignsAddNr', nil, c.green_bg)
hl('GitSignsChangeNr', nil, c.yellow_2)
hl('GitSignsDeleteNr', nil, c.red_bg)

--
-- Which Key
--

hl('WhichKey', c.red_1, nil, 'bold')
hl('WhichKeyGroup', c.fg_1)
hl('WhichKeySeparator', c.fg_1)
hl('WhichKeyDesc', c.fg_1)

-- Highlight trailing space when not in insert mode:
local highlight_trailing = vim.api.nvim_create_augroup('HighlightTrailing', {})

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead', 'InsertLeave' }, {
  callback = function()
    hl('trail_space', nil, c.red_1)
  end,
  group = highlight_trailing,
  pattern = '*',
})

vim.api.nvim_create_autocmd('InsertEnter', {
  callback = function()
    hl('trail_space')
  end,
  group = highlight_trailing,
  pattern = '*',
})

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  callback = function()
    vim.cmd([[match trail_space /\s\+$/]])
  end,
  group = highlight_trailing,
  pattern = '*',
})
