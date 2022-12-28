return {
  init = function(null_ls)
    local null_ls_sources = {
      null_ls.builtins.formatting.isort,
      null_ls.builtins.formatting.black,
      null_ls.builtins.diagnostics.ruff,
      null_ls.builtins.formatting.stylua.with({
        extra_args = {
          '--column-width',
          '80',
          '--indent-type',
          'Spaces',
          '--indent-width',
          2,
          '--quote-style',
          'AutoPreferSingle',
        },
      }),
      null_ls.builtins.formatting.deno_fmt.with({
        filetypes = { 'markdown' },
        extra_args = { '--options-line-width', '79' },
      }),
      null_ls.builtins.formatting.shfmt,
      null_ls.builtins.diagnostics.shellcheck,
      null_ls.builtins.formatting.gofmt,
      null_ls.builtins.formatting.djhtml,
    }
    null_ls.setup({
      sources = null_ls_sources,
      on_attach = require('plugins.lsp').lsp_on_attach,
    })
  end,
}
