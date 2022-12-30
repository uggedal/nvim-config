return {
  'jose-elias-alvarez/buftabline.nvim',
  lazy = false,
  config = function()
    require('buftabline').setup({
      auto_hide = true,
      go_to_maps = false,
      hlgroup = {
        normal = 'TabLine',
      },
    })

    local btab_cmds = require('buftabline.commands')

    for i = 1, 9 do
      vim.keymap.set('n', '<leader>' .. i, function()
        btab_cmds.buftarget(i, 'buffer')
      end, { desc = 'buffer ' .. i })
    end
  end,
}
