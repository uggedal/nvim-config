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
