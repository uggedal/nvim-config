return {
  'terrortylor/nvim-comment',
  cmd = 'CommentToggle',
  event = 'VeryLazy',
  dependencies = {
    'JoosepAlviste/nvim-ts-context-commentstring',
  },
  config = function()
    local ts_cc = require('ts_context_commentstring.internal')

    require('nvim_comment').setup({
      hook = function()
        ts_cc.update_commentstring({})
      end,
    })
  end,
}
