-- Disable movement with cursor keys:
for _, k in ipairs({ 'up', 'down', 'left', 'right' }) do
  vim.keymap.set('n', '<' .. k .. '>', '<nop>')
  vim.keymap.set('i', '<' .. k .. '>', '<nop>')
end

-- Disable man page lookup of word under cursor with K key:
vim.keymap.set('n', 'K', '<nop>')

-- Disable tab cycling keys (use buffers):
vim.keymap.set('n', 'gT', '<nop>')
vim.keymap.set('n', 'gt', '<nop>')

-- Move up/down by display lines when long lines wrap:
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')

-- Shorter bindings for split navigation:
for _, k in ipairs({ 'h', 'j', 'k', 'l' }) do
  vim.keymap.set('n', '<C-' .. k .. '>', '<C-w>' .. k)
end

-- Keep search matches in the middle of the window:
for _, k in ipairs({ '*', '#', 'n', 'N' }) do
  vim.keymap.set('n', k, k .. 'zzzv')
end

-- Stay in visual mode when indenting:
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Clear search highlight when clearing screen:
vim.keymap.set('n', '<c-l>', ':nohlsearch<cr><c-l>', { silent = true })

vim.g.mapleader = ','


local has_wk, wk = pcall(require, 'which-key')

if has_wk then
  wk.register({
    c = {
      name = 'clipboard',
      p = {
        '"+p',
        'paste from system clipboard',
      },
    },
  }, { prefix = '<leader>' })

  wk.register({
    c = {
      name = 'clipboard',
      y = {
        '"+y',
        'yank to system clipboard',
      },
    },
  }, { prefix = '<leader>', mode = 'v' })

  wk.register({
    p = {
      ':bp<CR>',
      'previous buffer',
    },
    n = {
      ':bn<CR>',
      'next buffer',
    },
    d = {
      ':bd<CR>',
      'delete buffer',
    },
    i = {
      ':set invpaste<CR>',
      'toggle paste mode',
    },
    g = {
      name = 'git',
      c = {
        function()
          vim.cmd([[!cd %:p:h && git add . && git ci -am sync && git push]])
        end,
        'git commit and sync',
      },
    },
  }, { prefix = '<leader>' })

  wk.register({
    e = {
      ':e <C-R>=expand("%:p:h") . "/"<CR>',
      'edit in cwd',
    },
  }, { prefix = '<leader>', silent = false })

  wk.register({
    ['['] = {
      d = {
        vim.diagnostic.goto_prev,
        'previous diagnostic',
      },
    },
    [']'] = {
      d = {
        vim.diagnostic.goto_next,
        'next diagnostic',
      },
    },
    g = {
      l = {
        vim.diagnostic.open_float,
        'view diagnostic',
      },
    },
  })
end)
