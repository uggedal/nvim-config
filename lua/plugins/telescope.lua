local req = require('util').req

return {
  init = function(telescope)
    telescope.load_extension('fzf')

    telescope.setup({
      defaults = {
        mappings = {
          i = {
            ['<C-s>'] = 'cycle_history_next',
            ['<C-r>'] = 'cycle_history_prev',
          },
        },
        vimgrep_arguments = {
          'rg',
          '--color',
          'never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
          '--smart-case',
          '--ignore',
          '--hidden',
          '-g',
          '!.git',
        },
      },
    })

    local tele_builtin = require('telescope.builtin')

    vim.keymap.set('n', '<c-p>', function()
      tele_builtin.find_files({
        find_command = {
          'rg',
          '--color',
          'never',
          '--files',
          '--ignore',
          '--hidden',
          '-g',
          '!.git',
        },
      })
    end)

    vim.keymap.set('n', '<c-g>', tele_builtin.live_grep)

    req('which-key', function(wk)
      wk.register({
        g = {
          name = 'git',
          l = {
            tele_builtin.git_bcommits,
            'git buffer commits',
          },
          L = {
            tele_builtin.git_commits,
            'git commits',
          },
          B = {
            tele_builtin.git_branches,
            'git branches',
          },
          s = {
            tele_builtin.git_status,
            'git status',
          },
        },
      }, { prefix = '<leader>' })
    end)
  end,
}
