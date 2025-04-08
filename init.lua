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
  add({
    source = 'ethanholz/nvim-lastplace'
  })
end)

later(function()
  add({
    source = 'jghauser/mkdir.nvim'
  })
  -- add({
  --   source = 'nvim-treesitter/nvim-treesitter',
  --   -- Use 'master' while monitoring updates in 'main'
  --   checkout = 'master',
  --   monitor = 'main',
  --   -- Perform action after every checkout
  --   hooks = { post_checkout = function() vim.cmd('TSUpdate') end },
  -- })
  -- Possible to immediately execute code which depends on the added plugin
  -- require('nvim-treesitter.configs').setup({
  --   ensure_installed = { 'lua', 'vimdoc' },
  --   highlight = { enable = true },
  -- })
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
