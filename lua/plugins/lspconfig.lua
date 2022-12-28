local req = require('util').req
local lsp_on_attach = require('plugins.lsp').lsp_on_attach

return {
  init = function(lspconfig)
    req('cmp_nvim_lsp', function(cmp_lsp)
      local lsp_capabilities = cmp_lsp.default_capabilities()

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

      lspconfig.gopls.setup({
        on_attach = lsp_on_attach,
        capabilities = lsp_capabilities,
      })

      lspconfig.sumneko_lua.setup({
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
    end)
  end,
}
