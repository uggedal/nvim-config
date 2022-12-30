return {
  {
    'NvChad/nvim-colorizer.lua',
    event = 'BufReadPre',
    config = {
      filetypes = { '*' },
      user_default_options = { names = false },
    },
  },
}
