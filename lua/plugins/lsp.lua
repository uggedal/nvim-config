local req = require('util').req

local lsp_format = function(bufnr)
  vim.lsp.buf.format({
    bufnr = bufnr,
    filter = function(client)
      return client.name == 'null-ls'
    end,
  })
end

local lsp_format_augroup = vim.api.nvim_create_augroup('LspFormat', {})

return {
  lsp_on_attach = function(client, bufnr)
    if client.supports_method('textDocument/formatting') then
      vim.api.nvim_clear_autocmds({ group = lsp_format_augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd('BufWritePre', {
        callback = function()
          lsp_format(bufnr)
        end,
        group = lsp_format_augroup,
        buffer = bufnr,
      })
    end
    req('which-key', function(wk)
      wk.register({
        g = {
          d = {
            vim.lsp.buf.definition,
            'lsp definition',
          },
          r = {
            vim.lsp.buf.rename,
            'lsp rename',
          },
        },
        K = {
          vim.lsp.buf.hover,
          'lsp symbol info',
        },
      }, { buffer = bufnr })
    end)
  end,
}
