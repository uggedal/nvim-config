local map = vim.keymap.set

-- Disable movement with cursor keys:
for _, k in ipairs({ 'up', 'down', 'left', 'right' }) do
  map('n', '<' .. k .. '>', '<nop>')
  map('i', '<' .. k .. '>', '<nop>')
end

-- Disable man page lookup of word under cursor with K key:
map('n', 'K', '<nop>')

-- Disable tab cycling keys (use buffers):
map('n', 'gT', '<nop>')
map('n', 'gt', '<nop>')

-- Move up/down by display lines when long lines wrap:
map('n', 'j', 'gj')
map('n', 'k', 'gk')

-- Shorter bindings for split navigation:
for _, k in ipairs({ 'h', 'j', 'k', 'l' }) do
  map('n', '<C-' .. k .. '>', '<C-w>' .. k)
end

-- Keep search matches in the middle of the window:
for _, k in ipairs({ '*', '#', 'n', 'N' }) do
  map('n', k, k .. 'zzzv')
end

-- Stay in visual mode when indenting:
map('v', '<', '<gv')
map('v', '>', '>gv')

-- Clear search highlight when clearing screen:
map('n', '<c-l>', ':nohlsearch<cr><c-l>', { silent = true })

vim.g.mapleader = ','

map('n', '<leader>cp', '"+p', { desc = 'paste from system clipboard' })
map('v', '<leader>cy', '"+y', { desc = 'yank to system clipboard' })

map('n', '<leader>p', ':bp<CR>', { desc = 'previous buffer' })
map('n', '<leader>n', ':bn<CR>', { desc = 'next buffer' })
map('n', '<leader>d', ':bd<CR>', { desc = 'delete buffer' })
map(
  'n',
  '<leader>e',
  ':e <C-R>=expand("%:p:h") . "/"<CR>',
  { desc = 'edit in cwd' }
)

map('n', '<leader>i', ':set invpaste<CR>', { desc = 'toggle paste mode' })

map(
  'n',
  '<leader>gc',
  '!cd %:p:h && git add . && git ci -am sync && git push',
  { desc = 'git commit and sync', silent = false }
)

map('n', '[d', vim.diagnostic.goto_prev, { desc = 'previous diagnostic' })
map('n', ']d', vim.diagnostic.goto_next, { desc = 'next diagnostic' })
map('n', 'gl', vim.diagnostic.open_float, { desc = 'view diagnostic' })
