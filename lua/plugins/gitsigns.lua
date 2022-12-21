local req = require('util').req

return {
  init = function(gitsigns)
    gitsigns.setup({
      signcolumn = false,
      numhl = true,
      on_attach = function(bufnr)
        req('which-key', function(wk)
          wk.register({
            g = {
              b = {
                package.loaded.gitsigns.blame_line,
                'git blame',
              },
            },
          }, { prefix = '<leader>', buffer = bufnr })
          wk.register({
            ['['] = {
              h = {
                package.loaded.gitsigns.prev_hunk,
                'previous git diff hunk',
              },
            },
            [']'] = {
              h = {
                package.loaded.gitsigns.next_hunk,
                'next git diff hunk',
              },
            },
          }, { buffer = bufnr })
        end)
      end,
    })
  end,
}
