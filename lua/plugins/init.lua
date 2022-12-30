return {
  { 'ethanholz/nvim-lastplace', event = 'BufReadPre', config = {} },
  { 'jghauser/mkdir.nvim', event = 'BufWritePre' },
}

-- req('packer', function(packer)
--   packer.startup({
--     function(use)
--
--       use('neovim/nvim-lspconfig')
--       use({
--         'jose-elias-alvarez/null-ls.nvim',
--         requires = { 'nvim-lua/plenary.nvim' },
--       })
--
--       use('hrsh7th/nvim-cmp')
--       use('hrsh7th/cmp-buffer')
--       use('hrsh7th/cmp-path')
--       use('hrsh7th/cmp-nvim-lsp')
--     end,
--   })
-- end)
--
-- req('lspconfig')
-- req('null-ls')
-- req('cmp')
--
