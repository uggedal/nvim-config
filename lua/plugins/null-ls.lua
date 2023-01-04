return {
  'jose-elias-alvarez/null-ls.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  event = 'BufReadPre',
  config = function()
    local null_ls = require('null-ls')

    local null_ls_sources = {
      null_ls.builtins.formatting.black,
      null_ls.builtins.formatting.ruff,
      null_ls.builtins.diagnostics.ruff,
      null_ls.builtins.diagnostics.mypy.with({
        command = 'venv/bin/mypy',
        condition = function(utils)
          return utils.root_has_file('venv/bin/mypy')
        end,
      }),

      null_ls.builtins.formatting.stylua,

      null_ls.builtins.formatting.deno_fmt.with({
        filetypes = { 'markdown' },
      }),

      null_ls.builtins.formatting.shfmt,
      null_ls.builtins.diagnostics.shellcheck,

      null_ls.builtins.formatting.gofmt,

      null_ls.builtins.formatting.djhtml,
    }

    null_ls.setup({
      sources = null_ls_sources,
      on_attach = require('lsp').lsp_on_attach,
    })
  end,
}
