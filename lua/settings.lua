-- Save undo history to file (enables undo between sessions):
vim.bo.undofile = true

-- Show line numbers:
vim.wo.number = true

-- Highlight column number 80:
vim.wo.colorcolumn = '80'

-- Break lines when wrapping at punctuation:
vim.wo.linebreak = true

-- Visually indent each wrapped line:
vim.wo.breakindent = true

-- Disable intro messages when starting vim without a file:
vim.o.shortmess = vim.o.shortmess .. 'I'

-- Ignore case when searching with all lowercase queries:
vim.o.ignorecase = true
vim.o.smartcase = true

-- Substitute all matches on a line:
vim.o.gdefault = true

-- Live preview of substitutions:
vim.o.inccommand = 'split'

-- Completion settings with consecurive presses of TAB:
--   1. Complete till longest common string
--   2. When more than one match, list all matches
--   3. Complete next full match. After last match, use original string.
vim.o.wildmode = 'longest,list,full'

-- Keep some lines above and below cursor:
vim.o.scrolloff = 3

-- Allow placing the curser where there is no character in visual block mode:
vim.o.virtualedit = 'block'

-- Wait 700ms for a mapped key sequence to complete:
vim.o.timeoutlen = 700

-- Disable default mouse support:
vim.o.mouse = ''

-- Highlight the line of the cursor only in insert mode:
local toggle_cursorline_group =
  vim.api.nvim_create_augroup('ToggleCursorLine', {})
vim.api.nvim_create_autocmd('InsertLeave', {
  callback = function()
    vim.opt.cursorline = false
  end,
  group = toggle_cursorline_group,
  pattern = '*',
})
vim.api.nvim_create_autocmd('InsertEnter', {
  callback = function()
    vim.opt.cursorline = true
  end,
  group = toggle_cursorline_group,
  pattern = '*',
})

-- Spelling:
vim.bo.spelllang = 'en'
local spelling = vim.api.nvim_create_augroup('Spelling', {})
vim.api.nvim_create_autocmd('FileType', {
  callback = function()
    vim.opt_local.spell = true
  end,
  group = spelling,
  pattern = {
    'gitcommit',
    'mail',
    'markdown',

    -- Languages with comment or string literal spelling support:
    'bash',
    'css',
    'go',
    'hcl',
    'json',
    'lua',
    'make',
    'python',
    'toml',
    'yaml',
  },
})

-- Diagnostics:
vim.diagnostic.config({
  virtual_text = false,
  float = {
    focusable = false,
    header = '',
    prefix = '',
    border = 'rounded',
    style = 'minimal',
  },
  jump = {
    float = true,
  },
})

-- Floating window border (for diagnostic and others):
vim.o.winborder = 'single'
