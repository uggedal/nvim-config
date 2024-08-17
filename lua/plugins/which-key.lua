return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  config = function()
    local wk = require('which-key')

    wk.setup({
      show_help = false,
      plugins = {
        spelling = {
          enabled = true,
        },
      },
    })

    wk.add({
      { '<leader>c', group = 'clipboard' },
      { mode = { 'n', 'v' } },
    })

    wk.add({
      { '<leader>g', group = 'git' },
      { '<leader>j', group = 'journal' },
      { '<leader>l', group = 'lsp' },
      { '<leader>t', group = 'todo' },
    })
  end,
}
