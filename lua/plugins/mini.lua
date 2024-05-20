return {
  'echasnovski/mini.nvim',
  version = '*',
  event = 'VeryLazy',
  config = function()
    require('mini.tabline').setup({
      show_icons = false,
    })
  end,
}
