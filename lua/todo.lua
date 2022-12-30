local has_tele_bultin, tele_builtin = pcall(require, 'telescope.builtin')

if not has_tele_bultin then
  return
end

local rg_sort_args = {
  '--sortr',
  'path',
}

local todo_items = function(box_re, title)
  return tele_builtin.grep_string({
    prompt_title = title,
    type_filter = 'markdown',
    additional_args = rg_sort_args,
    search = '\\s*- \\[' .. box_re .. '\\]',
    use_regex = true,
  })
end

local open_todos = function()
  return todo_items('[ -]', 'Open TODO items')
end

local done_todos = function()
  return todo_items('x', 'Done TODO items')
end

local moved_todos = function()
  return todo_items('>', 'Moved TODO items')
end

vim.keymap.set('n', '<leader>to', open_todos, { desc = 'open todo items' })
vim.keymap.set('n', '<leader>td', open_todos, { desc = 'done todo items' })
vim.keymap.set('n', '<leader>tm', moved_todos, { desc = 'moved todo items' })
