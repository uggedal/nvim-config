local rg_sort_args = {
  '--sortr',
  'path',
}

local todo_items = function(box_re, title)
  return require('telescope.builtin').grep_string({
    prompt_title = title,
    type_filter = 'markdown',
    additional_args = rg_sort_args,
    search = '\\s*- \\[' .. box_re .. '\\]',
    use_regex = true,
  })
end

return {
  open_todos = function()
    return todo_items('[ -]', 'Open TODO items')
  end,

  done_todos = function()
    return todo_items('x', 'Done TODO items')
  end,

  moved_todos = function()
    return todo_items('>', 'Moved TODO items')
  end,
}
