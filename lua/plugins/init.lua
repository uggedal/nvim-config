return {
  { 'ethanholz/nvim-lastplace', event = 'BufReadPre', config = {} },
  { 'jghauser/mkdir.nvim', event = 'BufWritePre' },
  {
    'uggedal/gh',
    priority = 1000,
    dev = true,
  },
}
