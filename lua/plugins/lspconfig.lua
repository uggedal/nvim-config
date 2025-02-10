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

    lspconfig.pylsp.setup({
      on_attach = lsp_on_attach,
      capabilities = lsp_capabilities,
    })

    if vim.fn.executable('bash-language-server') == 1 then
      lspconfig.bashls.setup({
        on_attach = lsp_on_attach,
        capabilities = lsp_capabilities,
      })
    end

    if vim.fn.executable('deno') == 1 then
      lspconfig.denols.setup({
        on_attach = lsp_on_attach,
        capabilities = lsp_capabilities,
        filetypes = { 'markdown' },
      })
    end

    lspconfig.gopls.setup({
      on_attach = lsp_on_attach,
      capabilities = lsp_capabilities,
    })

    if vim.fn.executable('lua-language-server') == 1 then
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
    end
  end,
}
