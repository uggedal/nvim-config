return {
  'neovim/nvim-lspconfig',
  event = 'BufReadPre',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    {
      'folke/neodev.nvim',
      config = {
        setup_jsonls = false,
      },
    },
  },
  config = function()
    local lspconfig = require('lspconfig')
    local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

    require('lspconfig.ui.windows').default_options.border = 'single'

    local lsp_on_attach = function(client, bufnr)
      require('lsp').lsp_on_attach(client, bufnr)

      vim.keymap.set('n', '<leader>li', ':LspInfo<cr>', {
        desc = 'lsp server info',
        buffer = bufnr,
        silent = true,
      })

      vim.keymap.set('n', '<leader>le', ':LspRestart<cr>', {
        desc = 'lsp server restart',
        buffer = bufnr,
        silent = true,
      })

      vim.keymap.set('n', '<leader>ls', ':LspStop<cr>', {
        desc = 'lsp server stop',
        buffer = bufnr,
        silent = true,
      })
    end

    lspconfig.jedi_language_server.setup({
      on_attach = lsp_on_attach,
      capabilities = lsp_capabilities,

      on_new_config = function(new_config, root_dir)
        local venv_dir = nil
        if root_dir == vim.fs.normalize('~/src/infra') then
          venv_dir = vim.fs.normalize('~/.local/pipx/venvs/pyinfra')
        elseif vim.fn.isdirectory(root_dir .. '/venv') ~= 0 then
          venv_dir = './venv'
        end

        if venv_dir ~= nil then
          new_config.init_options = {
            workspace = {
              environmentPath = venv_dir .. '/bin/python3',
            },
          }
        end
      end,
    })

    lspconfig.ruff_lsp.setup({
      on_attach = lsp_on_attach,
      capabilities = lsp_capabilities,
    })

    lspconfig.gopls.setup({
      on_attach = lsp_on_attach,
      capabilities = lsp_capabilities,
    })

    lspconfig.lua_ls.setup({
      on_attach = lsp_on_attach,
      capabilities = lsp_capabilities,
      settings = {
        Lua = {
          runtime = {
            version = 'LuaJIT',
          },
          diagnostics = {
            globals = { 'vim' },
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file('', true),
            checkThirdParty = false,
          },
          telemetry = {
            enable = false,
          },
          format = {
            enable = false,
          },
        },
      },
    })
  end,
}
