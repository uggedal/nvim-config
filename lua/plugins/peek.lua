return {
  'toppair/peek.nvim',
  build = 'deno task --quiet build:fast',
  init = function(peek)
    vim.api.nvim_create_user_command('PeekOpen', require('peek').open, {})
    vim.api.nvim_create_user_command('PeekClose', require('peek').close, {})
  end,
  config = {
    theme = 'light',
  },
  cmd = 'PeekOpen',
}
