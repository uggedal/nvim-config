return {
  'lewis6991/gitsigns.nvim',
  event = 'BufReadPre',
  config = {
    signcolumn = false,
    numhl = true,
    on_attach = function(bufnr)
      vim.keymap.set(
        'n',
        '<leader>gb',
        package.loaded.gitsigns.blame_line,
        { desc = 'git blame', buffer = bufnr }
      )
      vim.keymap.set(
        'n',
        '[h',
        package.loaded.gitsigns.prev_hunk,
        { desc = 'previous git diff hunk', buffer = bufnr }
      )
      vim.keymap.set(
        'n',
        ']h',
        package.loaded.gitsigns.next_hunk,
        { desc = 'next git diff hunk', buffer = bufnr }
      )
    end,
  },
}
