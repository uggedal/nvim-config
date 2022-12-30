return {
  'toppair/peek.nvim',
  build = 'deno task --quiet build:fast',
  init = function()
    vim.api.nvim_create_user_command('PeekOpen', function()
      require('peek').open()
    end, {})
    vim.api.nvim_create_user_command('PeekClose', function()
      require('peek').close()
    end, {})
  end,
  config = {
    theme = 'light',
  },
  cmd = 'PeekOpen',
}
