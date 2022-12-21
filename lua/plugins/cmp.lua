local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0
    and vim.api
        .nvim_buf_get_lines(0, line - 1, line, true)[1]
        :sub(col, col)
        :match('%s')
      == nil
end

return {
  init = function(cmp)
    cmp.setup({
      mapping = cmp.mapping.preset.insert({
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { 'i', 's' }),

        ['<S-Tab>'] = cmp.mapping(function()
          if cmp.visible() then
            cmp.select_prev_item()
          end
        end, { 'i', 's' }),
      }),

      completion = {
        autocomplete = false,
      },

      experimental = {
        ghost_text = true,
      },

      sources = cmp.config.sources({
        { name = 'path' },
        { name = 'nvim_lsp' },
        {
          name = 'buffer',
          option = {
            get_bufnrs = vim.api.nvim_list_bufs, -- all buffers as source
          },
        },
      }),
    })
  end,
}
