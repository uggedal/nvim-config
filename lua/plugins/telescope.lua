return {
  'nvim-telescope/telescope.nvim',
  cmd = 'Telescope',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
  keys = {
    {
      '<c-p>',
      function()
        require('telescope.builtin').find_files({
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
      end,
      desc = 'find files',
    },
    {
      '<c-g>',
      function()
        require('telescope.builtin').live_grep()
      end,
      desc = 'grep files',
    },
    {
      'gr',
      function()
        require('telescope.builtin').lsp_references({ jump_type = 'never' })
      end,
      desc = 'lsp references',
    },
    {
      '<leader>gl',
      function()
        require('telescope.builtin').git_bcommits()
      end,
      desc = 'git buffer commits',
    },
    {
      '<leader>gL',
      function()
        require('telescope.builtin').git_commits()
      end,
      desc = 'git commits',
    },
    {
      '<leader>gB',
      function()
        require('telescope.builtin').git_branches()
      end,
      desc = 'git branches',
    },
    {
      '<leader>gs',
      function()
        require('telescope.builtin').git_status()
      end,
      desc = 'git status',
    },
  },
  config = function()
    local telescope = require('telescope')

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

    telescope.load_extension('fzf')
  end,
}
