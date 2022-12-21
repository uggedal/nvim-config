local req = require('util').req
local lsp_on_attach = require('plugins.lsp').lsp_on_attach

return {
  init = function(lspconfig)
    req('cmp_nvim_lsp', function(cmp_lsp)
      local lsp_capabilities = cmp_lsp.default_capabilities()

      local jedi_env = function(env)
        return {
          pylsp = {
            plugins = {
              jedi = {
                environment = env,
              },
            },
          },
        }
      end

      lspconfig.pylsp.setup({
        on_attach = lsp_on_attach,
        capabilities = lsp_capabilities,
        on_init = function(client)
          local path = client.workspace_folders[1].name

          if path == vim.fs.normalize('~/src/infra') then
            client.config.settings =
              jedi_env(vim.fs.normalize('~/.local/pipx/venvs/pyinfra'))
          elseif vim.fn.isdirectory(path .. '/venv') ~= 0 then
            client.config.settings = jedi_env('./venv')
          end

          client.notify('workspace/didChangeConfiguration')
          return true
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
