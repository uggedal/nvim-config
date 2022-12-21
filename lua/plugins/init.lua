local req = require('util').req

local packer_dir = vim.fn.stdpath('data')
  .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(packer_dir)) > 0 then
  vim.fn.execute(
    '!git clone https://github.com/wbthomason/packer.nvim ' .. packer_dir
  )
end

req('packer', function(packer)
  packer.startup({
    function(use)
      use('wbthomason/packer.nvim')

      use('folke/which-key.nvim')

      use({
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
      })
      use({
        'yioneko/nvim-yati',
        requires = 'nvim-treesitter/nvim-treesitter',
      })
      use('JoosepAlviste/nvim-ts-context-commentstring')
      use({
        'nvim-treesitter/playground',
        cmd = { 'TSHighlightCapturesUnderCursor', 'TSPlaygroundToggle' },
      })

      use({
        'nvim-telescope/telescope.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
      })
      use({ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' })

      use('jose-elias-alvarez/buftabline.nvim')
      use('lewis6991/gitsigns.nvim')
      use('NvChad/nvim-colorizer.lua')

      use('terrortylor/nvim-comment')
      use('ethanholz/nvim-lastplace')
      use('jghauser/mkdir.nvim')

      use('jakewvincent/mkdnflow.nvim')

      use('neovim/nvim-lspconfig')
      use({
        'jose-elias-alvarez/null-ls.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
      })

      use('hrsh7th/nvim-cmp')
      use('hrsh7th/cmp-buffer')
      use('hrsh7th/cmp-path')
      use('hrsh7th/cmp-nvim-lsp')
    end,
    config = {
      display = {
        open_fn = require('packer.util').float,
      },
    },
  })
end)

req('which-key')

req('nvim-treesitter.configs', 'treesitter')

req('spellsitter', function(spellsitter)
  spellsitter.setup()
end)

req('telescope')

req('buftabline', function(buftabline)
  buftabline.setup({
    auto_hide = true,
    go_to_maps = false,
    hlgroup = {
      normal = 'TabLine',
    },
  })
end)

req('gitsigns')

req('colorizer', function(colorizer)
  colorizer.setup({
    filetypes = { '*' },
    user_default_options = { names = false },
  })
end)

req('nvim_comment', function(comment)
  req('ts_context_commentstring.internal', function(ts_cc)
    comment.setup({
      hook = function()
        ts_cc.update_commentstring({})
      end,
    })
  end)
end)

req('nvim-lastplace', function(lastplace)
  lastplace.setup({})
end)

pcall(require, 'mkdir')

req('mkdnflow')

req('lspconfig')
req('null-ls')
req('cmp')
