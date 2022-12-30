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
      vim.api.nvim_clear_autocmds({
        group = lsp_format_augroup,
        buffer = bufnr,
      })
      vim.api.nvim_create_autocmd('BufWritePre', {
        callback = function()
          lsp_format(bufnr)
        end,
        group = lsp_format_augroup,
        buffer = bufnr,
      })
    end

    vim.keymap.set(
      'n',
      'gd',
      vim.lsp.buf.definition,
      { desc = 'lsp definition', buffer = bufnr }
    )
    vim.keymap.set(
      'n',
      'gr',
      vim.lsp.buf.rename,
      { desc = 'lsp rename', buffer = bufnr }
    )
    vim.keymap.set(
      'n',
      'K',
      vim.lsp.buf.hover,
      { desc = 'lsp symbol info', buffer = bufnr }
    )
  end,
}
