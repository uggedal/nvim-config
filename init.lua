local path_package = vim.fn.stdpath('data') .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.nvim'

if not vim.loop.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local clone_cmd = {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/echasnovski/mini.nvim',
    mini_path,
  }
  vim.fn.system(clone_cmd)
  vim.cmd('packadd mini.nvim | helptags ALL')
  vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

require('mini.deps').setup({ path = { package = path_package } })

local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

now(function()
  require('gh')
  vim.o.background = 'light'
  vim.cmd('colorscheme gh')

  require('settings')
  require('languages')
  require('keymaps')

  require('mini.tabline').setup({
    show_icons = false,
  })

  require('mini.misc').setup_restore_cursor()
end)

now(function()
  on_attach = require('lsp').on_attach

  add({
    source = 'nvimtools/none-ls.nvim',
    depends = {
      'nvim-lua/plenary.nvim',
      'gbprod/none-ls-shellcheck.nvim',
    },
  })

  local null_ls = require('null-ls')

  local null_ls_sources = {
    null_ls.builtins.formatting.stylua,
  }

  null_ls.setup({
    sources = null_ls_sources,
    border = 'single',
    on_attach = on_attach,
  })

  vim.lsp.config('*', {
    on_attach = on_attach,
  })

  vim.lsp.config.pylsp = {
    cmd = { 'pylsp' },
    root_markers = { 'pyproject.toml' },
    filetypes = { 'python' },
  }

  vim.lsp.config.bashls = {
    cmd = { 'bash-language-server', 'start' },
    root_markers = { 'pyproject.toml' },
    filetypes = { 'bash', 'sh' },
  }

  vim.lsp.config.denols = {
    cmd = { 'deno', 'lsp' },
    filetypes = { 'markdown' },
  }

  vim.lsp.enable('pylsp')
  vim.lsp.enable('bashls')

  if vim.fn.executable('deno') == 1 then
    vim.lsp.enable('denols')
  end
end)

later(function()
  add('jghauser/mkdir.nvim')
end)

later(function()
  add({
    source = 'nvim-treesitter/nvim-treesitter',
    hooks = {
      post_checkout = function()
        vim.cmd('TSUpdate')
      end,
    },
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
  local pick = require('mini.pick')
  local extra = require('mini.extra')

  pick.setup({
    options = {
      content_from_bottom = true,
    },
    source = {
      show = pick.default_show, -- disable icons
    },
  })
  extra.setup()

  vim.keymap.set('n', '<c-p>', pick.builtin.files, { desc = 'find files' })
  vim.keymap.set('n', '<c-g>', pick.builtin.grep_live, { desc = 'grep files' })
  vim.keymap.set('n', 'grr', function()
    extra.pickers.lsp({ scope = 'references' })
  end, { desc = 'lsp references' })
  vim.keymap.set('n', '<leader>gl', function()
    extra.pickers.git_commits({ path = vim.fn.expand('%:p') })
  end, { desc = 'git buffer commits' })
  vim.keymap.set(
    'n',
    '<leader>gL',
    extra.pickers.git_commits,
    { desc = 'git commits' }
  )
  vim.keymap.set(
    'n',
    '<leader>gB',
    extra.pickers.git_branches,
    { desc = 'git branches' }
  )
end)

later(function()
  require('mini.clue').setup({
    triggers = {
      { mode = 'n', keys = '<Leader>' },
      { mode = 'x', keys = '<Leader>' },
      { mode = 'n', keys = 'g' },
      { mode = 'x', keys = 'g' },
    },
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
