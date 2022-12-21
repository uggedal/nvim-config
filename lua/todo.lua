local has_wk, wk = pcall(require, 'which-key')
local has_tele_bultin, tele_builtin = pcall(require, 'telescope.builtin')

if not has_wk or not has_tele_bultin then
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

wk.register({
  t = {
    name = 'todo',
    o = {
      open_todos,
      'open todo items',
    },
    d = {
      done_todos,
      'done todo items',
    },
    m = {
      moved_todos,
      'moved todo items',
    },
  },
}, { prefix = '<leader>' })
