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

    for _, m in ipairs({ 'n', 'v' }) do
      wk.register({
        ['<leader>c'] = {
          name = 'clipboard',
        },
      }, { mode = m })
    end

    wk.register({
      ['<leader>g'] = {
        name = 'git',
      },
      ['<leader>l'] = {
        name = 'lsp',
      },
      ['<leader>j'] = {
        name = 'journal',
      },
      ['<leader>t'] = {
        name = 'todo',
      },
    })
  end,
}
