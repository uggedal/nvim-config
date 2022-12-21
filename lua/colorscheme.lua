vim.o.background = 'light'

require('gh')

-- Highlight trailing space when not in insert mode:
local highlight_trailing = vim.api.nvim_create_augroup('HighlightTrailing', {})
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  command = 'highlight trail_space guibg=' .. vim.g.terminal_color_1,
  group = highlight_trailing,
  pattern = '*',
})
vim.api.nvim_create_autocmd('InsertEnter', {
  command = 'highlight trail_space guibg=NONE',
  group = highlight_trailing,
  pattern = '*',
})
vim.api.nvim_create_autocmd('InsertLeave', {
  command = 'highlight trail_space guibg=' .. vim.g.terminal_color_1,
  group = highlight_trailing,
  pattern = '*',
})
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  command = [[match trail_space /\s\+$/]],
  group = highlight_trailing,
  pattern = '*',
})
