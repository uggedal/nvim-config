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

local deps = require('mini.deps')
deps.setup({ path = { package = path_package } })

deps.now(function()
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

deps.now(function()
  vim.lsp.config('*', {
    on_attach = require('lsp').on_attach,
    root_markers = { '.git' },
  })

  vim.lsp.config.pylsp = {
    cmd = { 'uv', 'run', 'pylsp' },
    root_markers = { 'pyproject.toml' },
    filetypes = { 'python' },
  }

  vim.lsp.config.bashls = {
    cmd = { 'bash-language-server', 'start' },
    root_markers = { 'pyproject.toml' },
    filetypes = { 'bash', 'zsh', 'sh' },
  }

  vim.lsp.config.rust_analyzer = {
    cmd = { 'rust-analyzer' },
    root_markers = { 'Cargo.toml' },
    filetypes = { 'rust' },
    settings = {
      ['rust-analyzer'] = {
        checkOnSave = {
          enable = true,
          command = 'clippy',
        },
      },
    },
  }

  vim.lsp.config.gopls = {
    cmd = { 'gopls' },
    root_markers = { 'go.mod' },
    filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
    settings = {
      gopls = {
        gofumpt = true,
      },
    },
  }

  vim.lsp.config.golangci = {
    cmd = { 'golangci-lint-langserver' },
    root_markers = { 'go.mod' },
    filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
    init_options = {
      command = {
        'golangci-lint',
        'run',
        '--output.json.path=stdout',
        '--show-stats=false',
      },
    },
  }

  vim.lsp.config.luals = {
    cmd = { 'lua-language-server' },
    root_markers = { 'pyproject.toml' },
    filetypes = { 'lua' },
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
        },
        diagnostics = {
          globals = { 'vim' },
          neededFileStatus = {
            ['codestyle-check'] = 'Any',
          },
        },
        workspace = {
          library = {
            [vim.fn.expand('$VIMRUNTIME/lua')] = true,
            [vim.fn.stdpath('config') .. '/lua'] = true,
          },
        },
        format = {
          enable = true,
          defaultConfig = {
            indent_style = 'space',
            indent_size = '2',
            quote_style = 'single',
            max_line_length = '79',
            trailing_table_separator = 'smart',
          },
        },
      },
    },
  }

  vim.lsp.config.denols = {
    cmd = { 'deno', 'lsp' },
    filetypes = { 'markdown' },
  }

  vim.lsp.config.taplo = {
    cmd = { 'taplo', 'lsp', 'stdio' },
    filetypes = { 'toml' },
  }

  vim.lsp.enable({ 'pylsp', 'bashls', 'luals' })

  if vim.fn.executable('rust-analyzer') == 1 then
    vim.lsp.enable('rust_analyzer')
  end

  if vim.fn.executable('gopls') == 1 then
    vim.lsp.enable('gopls')
  end

  if vim.fn.executable('golangci-lint-langserver') == 1 then
    vim.lsp.enable('golangci')
  end

  if vim.fn.executable('deno') == 1 then
    vim.lsp.enable('denols')
  end

  if vim.fn.executable('taplo') == 1 then
    vim.lsp.enable('taplo')
  end
end)

deps.later(function()
  deps.add('jghauser/mkdir.nvim')
end)

deps.now(function()
  local ts_parsers = {
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
    'gotmpl',
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
    'zig',
  }
  local install_ts_parsers = function(args)
    -- See https://github.com/echasnovski/mini.nvim/discussions/1831
    vim.cmd('packadd ' .. args.name)
    require('nvim-treesitter').install(ts_parsers):wait()
    require('nvim-treesitter').update():wait()
  end

  deps.add({
    source = 'nvim-treesitter/nvim-treesitter',
    checkout = 'main', -- master branch has been archived
    hooks = {
      post_install = install_ts_parsers,
      post_checkout = install_ts_parsers,
    },
  })
  vim.api.nvim_create_autocmd('FileType', {
    callback = function(event)
      local filetype = event.match
      local lang = vim.treesitter.language.get_lang(filetype)

      if not lang then
        return
      end

      if not vim.tbl_contains(require('nvim-treesitter.config').get_available(), lang) then
        return
      end

      vim.treesitter.start()
      vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      vim.bo.indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
    end,
    group = vim.api.nvim_create_augroup('TSSetup', {}),
  })
end)

deps.later(function()
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

deps.later(function()
  require('mini.clue').setup({
    triggers = {
      { mode = 'n', keys = '<Leader>' },
      { mode = 'x', keys = '<Leader>' },
      { mode = 'n', keys = 'g' },
      { mode = 'x', keys = 'g' },
    },
  })
end)

deps.later(function()
  require('mini.diff').setup({
    mappings = {
      apply = '',
      reset = '',
    },
  })
end)
