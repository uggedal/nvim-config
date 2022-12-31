return {
  'uggedal/todo',
  dependencies = {
    'nvim-telescope/telescope.nvim',
  },
  dev = true,
  keys = {
    {
      '<leader>to',
      function()
        require('todo').open_todos()
      end,
      desc = 'open todo items',
    },
    {
      '<leader>td',
      function()
        require('todo').done_todos()
      end,
      desc = 'done todo items',
    },
    {
      '<leader>tm',
      function()
        require('todo').moved_todos()
      end,
      desc = 'moved todo items',
    },
  },
}
