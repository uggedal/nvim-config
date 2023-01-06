return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  -- event = 'BufReadPost',
  lazy = false,
  dependencies = {
    'yioneko/nvim-yati',
    'JoosepAlviste/nvim-ts-context-commentstring',
  },
  config = function()
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
        -- Disabled until generation from grammar is not needed: 'gitignore',
        'go',
        'gomod',
        'help',
        'html',
        'javascript',
        'json',
        'lua',
        'make',
        'markdown',
        'markdown_inline',
        'python',
        'query',
        'regex',
        'rust',
        -- Disabled until generation from grammar is not needed: 'sql',
        'terraform',
        'toml',
        'vim',
        'yaml',
      },
      highlight = { enable = true },
      indent = {
        enable = true,
        -- Disable indent for languages handled by yati:
        disable = {
          'c',
          'cpp',
          'css',
          'html',
          'javascript',
          'json',
          'lua',
          'rust',
          'python',
          'toml',
        },
      },
      yati = { enable = true },
      context_commentstring = { enable = true, enable_autocmd = false },
    })

    local ts_query = require('vim.treesitter.query')

    local md_inline_hl = ts_query.get_query('markdown_inline', 'highlights')

    local md_inline_files =
      ts_query.get_query_files('markdown_inline', 'highlights')

    md_inline_mod = {}

    if #md_inline_files == 1 then
      for line in io.lines(md_inline_files[1]) do
        -- Remove conceal of shortcut links, also conceals pending todo: - [-]
        if line:match('^; Conceal shortcut links') ~= nil then
          break
        end
        table.insert(md_inline_mod, line)
      end
    end

    -- -- Add pending/moved captures:
    table.insert(
      md_inline_mod,
      [[
      (shortcut_link
        (link_text) @text.todo.pending
        (#eq? @text.todo.pending "-")
      ) @text.todo.pending
    ]]
    )

    table.insert(
      md_inline_mod,
      [[
      (shortcut_link
        (link_text) @text.todo.moved
        (#eq? @text.todo.moved ">")
      ) @text.todo.moved
    ]]
    )

    ts_query.set_query(
      'markdown_inline',
      'highlights',
      table.concat(md_inline_mod, '\n')
    )
  end,
}
