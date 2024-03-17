return {
  'echasnovski/mini.nvim',
  version = '*',
  event = 'VeryLazy',
  dependencies = {
    'JoosepAlviste/nvim-ts-context-commentstring',
  },
  config = function()
    require('ts_context_commentstring').setup({
      enable_autocmd = false,
    })
    require('mini.comment').setup({
      options = {
        custom_commentstring = function()
          return require('ts_context_commentstring').calculate_commentstring()
            or vim.bo.commentstring
        end,
      },
    })

    require('mini.tabline').setup({
      show_icons = false,
    })
  end,
}
