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
  end,
}
