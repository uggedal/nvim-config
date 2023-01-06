local c = require('gh.colors')

vim.cmd('hi clear')
if vim.fn.exists('syntax_on') then
  vim.cmd('syntax reset')
end

vim.o.termguicolors = true
vim.g.colors_name = 'gh'

local function hl(hls)
  for group, opts in pairs(hls) do
    vim.api.nvim_set_hl(0, group, opts)
  end
end

hl(require('gh.editor'))
hl(require('gh.syntax'))
hl(require('gh.plugins'))

--
-- TODO: LSP (should probably use non-Lsp prefixed variants)
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

-- Highlight trailing space when not in insert mode:
local highlight_trailing = vim.api.nvim_create_augroup('HighlightTrailing', {})

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead', 'InsertLeave' }, {
  callback = function()
    vim.cmd('highlight trail_space guibg=' .. c.red_1)
  end,
  group = highlight_trailing,
  pattern = '*',
})

vim.api.nvim_create_autocmd('InsertEnter', {
  callback = function()
    vim.cmd('highlight trail_space guibg=NONE')
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
