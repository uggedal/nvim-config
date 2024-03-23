return {
  'nvimtools/none-ls.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  event = 'BufReadPre',
  config = function()
    local null_ls = require('null-ls')

    local null_ls_sources = {
      null_ls.builtins.formatting.stylua,

      null_ls.builtins.formatting.shfmt,

      null_ls.builtins.formatting.gofmt,
    }

    local lsp_on_attach = function(client, bufnr)
      require('lsp').lsp_on_attach(client, bufnr)

      vim.keymap.set('n', '<leader>ln', ':NullLsInfo<cr>', {
        desc = 'null-ls info',
        buffer = bufnr,
        silent = true,
      })
    end

    null_ls.setup({
      sources = null_ls_sources,
      border = 'single',
      on_attach = lsp_on_attach,
    })
  end,
}
