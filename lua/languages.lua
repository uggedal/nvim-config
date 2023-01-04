local spaces = function(n)
  vim.bo.expandtab = true
  vim.bo.softtabstop = n
  vim.bo.tabstop = n
  vim.bo.shiftwidth = n
  vim.o.shiftround = true
end

-- Setup different levels of space based indent for some syntaxes:
local spaces_or_tabs = vim.api.nvim_create_augroup('SpacesOrTabs', {})
vim.api.nvim_create_autocmd('FileType', {
  callback = function()
    spaces(4)
  end,
  group = spaces_or_tabs,
  pattern = { 'python', 'html', 'jinja.html', 'css' },
})
vim.api.nvim_create_autocmd('FileType', {
  callback = function()
    spaces(2)
  end,
  group = spaces_or_tabs,
  pattern = { 'yaml', 'lua', 'markdown' },
})

-- Textfiles should be broken to a limited width:
vim.api.nvim_create_autocmd('FileType', {
  command = 'setlocal textwidth=79',
  group = vim.api.nvim_create_augroup('TextWidth', {}),
  pattern = { 'mail', 'markdown' },
})

-- Textfiles should not have line numbering
vim.api.nvim_create_autocmd('FileType', {
  command = 'setlocal nonumber',
  group = vim.api.nvim_create_augroup('NoNumber', {}),
  pattern = { 'mail', 'markdown' },
})

-- Markdown conceal:
vim.api.nvim_create_autocmd('FileType', {
  command = 'setlocal conceallevel=1',
  group = vim.api.nvim_create_augroup('MarkdownConceal', {}),
  pattern = { 'markdown' },
})
