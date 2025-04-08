-- Clone 'mini.nvim' manually in a way that it gets managed by 'mini.deps'
local path_package = vim.fn.stdpath('data') .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.nvim'

if not vim.loop.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local clone_cmd = { 'git', 'clone', '--filter=blob:none', 'https://github.com/echasnovski/mini.nvim', mini_path }
  vim.fn.system(clone_cmd)
  vim.cmd('packadd mini.nvim | helptags ALL')
  vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

-- Set up 'mini.deps' (customize to your liking)
require('mini.deps').setup({ path = { package = path_package } })

-- Use 'mini.deps'. `now()` and `later()` are helpers for a safe two-stage
-- startup and are optional.
local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

-- Safely execute immediately
now(function()
  require('gh')
  vim.o.background = 'light'
  vim.cmd('colorscheme gh')
end)
now(function()
  require('settings')
  require('languages')
  require('keymaps')
end)

now(function()
  require('mini.tabline').setup({
    show_icons = false,
  })
end)

-- Safely execute later
-- later(function() require('mini.ai').setup() end)
-- later(function() require('mini.comment').setup() end)
-- later(function() require('mini.pick').setup() end)
-- later(function() require('mini.surround').setup() end)

now(function()
  -- Use other plugins with `add()`. It ensures plugin is available in current
  -- session (installs if absent)
  -- add({
  --   source = 'neovim/nvim-lspconfig',
  --   -- Supply dependencies near target plugin
  --   depends = { 'williamboman/mason.nvim' },
  -- })
  add('ethanholz/nvim-lastplace')
end)

later(function()
  add('jghauser/mkdir.nvim')
end)

later(function()
  add({
    source = 'nvim-treesitter/nvim-treesitter',
    hooks = { post_checkout = function() vim.cmd('TSUpdate') end },
  })
  require('nvim-treesitter.configs').setup({
    ensure_installed = {
      'bash',
      'c',
      'css',
      'comment',
      'diff',
      'git_rebase',
      'gitattributes',
      'gitcommit',
      'git_config',
      'gitignore',
      'go',
      'gomod',
      'gosum',
      'html',
      'javascript',
      'json',
      'lua',
      'make',
      'markdown',
      'markdown_inline',
      'powershell',
      'python',
      'query',
      'regex',
      'rust',
      'sql',
      'terraform',
      'toml',
      'vim',
      'vimdoc',
      'yaml',
    },
    highlight = { enable = true },
    indent = { enable = true },
  })
end)

later(function()
  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0
      and vim.api
          .nvim_buf_get_lines(0, line - 1, line, true)[1]
          :sub(col, col)
          :match('%s')
        == nil
  end

  add({
    source = 'hrsh7th/nvim-cmp',
    depends = {
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lsp',
    }
  })

  local cmp = require('cmp')

  cmp.setup({
    mapping = {
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
    },

    completion = {
      autocomplete = false,
    },

    experimental = {
      ghost_text = true,
    },

    sources = cmp.config.sources({
      { name = 'path' },
      { name = 'nvim_lsp' },
    })
  })
end)

later(function()
  local build_fzf_native = function(args)
    vim.cmd("lcd " .. args.path)
		vim.cmd("!make -s")
		vim.cmd("lcd -")
  end

  add({
    source = 'nvim-telescope/telescope.nvim',
    depends = {
      'nvim-lua/plenary.nvim',
      {
        source = 'nvim-telescope/telescope-fzf-native.nvim',
        hooks = {
          post_install = build_fzf_native,
          post_checkout = build_fzf_native,
        }
      }
    }
  })

  vim.keymap.set(
    'n',
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
    { desc = 'find files' }
  )
  vim.keymap.set(
    'n',
    '<c-g>',
    function()
      require('telescope.builtin').live_grep()
    end,
    { desc = 'grep files' }
  )
  vim.keymap.set(
    'n',
    'gr',
    function()
      require('telescope.builtin').lsp_references({ jump_type = 'never' })
    end,
    { desc = 'lsp references' }
  )
  vim.keymap.set(
    'n',
    '<leader>gl',
    function()
      require('telescope.builtin').git_bcommits()
    end,
    { desc = 'git buffer commits' }
  )
  vim.keymap.set(
    'n',
    '<leader>gL',
    function()
      require('telescope.builtin').git_commits()
    end,
    { desc = 'git commits' }
  )
  vim.keymap.set(
    'n',
    '<leader>gB',
    function()
      require('telescope.builtin').git_branches()
    end,
    { desc = 'git branches' }
  )
  vim.keymap.set(
    'n',
    '<leader>gs',
    function()
      require('telescope.builtin').git_status()
    end,
    { desc = 'git status' }
  )

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
end)

later(function()
  require('mini.clue').setup({
    triggers = {
      { mode = 'n', keys = '<Leader>' },
      { mode = 'x', keys = '<Leader>' },
      { mode = 'n', keys = 'g' },
      { mode = 'x', keys = 'g' },
    }
  })
end)

later(function()
  add('lewis6991/gitsigns.nvim')

  local gitsigns = require('gitsigns')

  gitsigns.setup({
    signcolumn = false,
    numhl = true,
    on_attach = function(bufnr)
      vim.keymap.set(
        'n',
        '<leader>gb',
        gitsigns.blame_line,
        { desc = 'git blame', buffer = bufnr }
      )
      vim.keymap.set(
        'n',
        '[h',
        gitsigns.prev_hunk,
        { desc = 'previous git diff hunk', buffer = bufnr }
      )
      vim.keymap.set(
        'n',
        ']h',
        gitsigns.next_hunk,
        { desc = 'next git diff hunk', buffer = bufnr }
      )
    end,
  })
end)
