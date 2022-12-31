return {
  'uggedal/journal',
  dependencies = {
    'nvim-telescope/telescope.nvim',
  },
  dev = true,
  config = {
    journaldir = vim.fs.normalize('~/src/notes/journal'),
  },
  keys = {
    {
      '<leader>jt',
      function()
        require('journal').journal_today()
      end,
      desc = 'today',
    },
    {
      '<leader>jm',
      function()
        require('journal').journal_tomorrow()
      end,
      desc = 'tomorrow',
    },
    {
      '<leader>jf',
      function()
        require('journal').journal_find()
      end,
      desc = 'find',
    },
  },
}
