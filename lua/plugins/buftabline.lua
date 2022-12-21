local req = require('util').req

return {
  init = function(buftabline)
    buftabline.setup({
      auto_hide = true,
      go_to_maps = false,
      hlgroup = {
        normal = 'TabLine',
      },
    })

    local btab_cmds = require('buftabline.commands')

    req('which-key', function(wk)
      local buftabline_maps = {}

      for i = 1, 9 do
        buftabline_maps[tostring(i)] = {
          function()
            btab_cmds.buftarget(i, 'buffer')
          end,
          'buffer ' .. i,
        }
      end

      wk.register(buftabline_maps, { prefix = '<leader>' })
    end)
  end,
}
