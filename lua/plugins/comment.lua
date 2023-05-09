return {
  'echasnovski/mini.comment',
  event = 'VeryLazy',
  dependencies = {
    'JoosepAlviste/nvim-ts-context-commentstring',
  },
  config = function()
    require('mini.comment').setup({
      hooks = {
        pre = function()
          local ts_cc = require('ts_context_commentstring.internal')
          ts_cc.update_commentstring({})
        end,
      },
    })
  end,
}
