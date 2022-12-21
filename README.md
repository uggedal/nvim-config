# Neovim config

Neovim config in lua.

## Custom plugins

- [gh](lua/gh.lua): custom GitHub based color scheme (slight differences from
  the popular [projekt0n/github-nvim-theme][gh-theme]).
- [journal](lua/journal.lua): markdown based daily journal with task migration:
  - `,jt`: open or create journal for today.
  - `,jm`: open or create journal for tomorrow.
  - `,jf`: find a journal entry.
- [todo](lua/todo.lua): TODO item handler:
  - `,to`: find open or pending TODO items.
  - `,td`: find done TODO items.
  - `,tm`: find migrated TODO items.

## Other plugins

- [which-key](lua/plugins/which-key.lua) with spelling suggestions (`z=`).
- [treesitter](lua/plugins/treesitter.lua) with custom queries for pending
  (`- [-]`) and moved (`- [>]`) todo items.
- `nvim-yati` for better `treesitter` indent (especially Python).
- `treesitter/playground` for debugging tree-sitter queries.
- [telescope](lua/plugins/telescope.lua) with `telescope-fzf-native` for
  finding files (`<c-p>`) and live grep (`<c-g`). Also used for git operations:
  - `,gl`: list commits of current file.
  - `,gL`: list all commits.
  - `,gB`: list git branches.
  - `,gs`: show git status
- [buftabline](lua/plugins[buftabline.lua) for buffer list in the tabline with
  mappings `,1` to `,9` to switch to buffer with corresponding index.
- [gitsigns](lua/plugins/gitsigns.lua) showing diffs in number column and
  mappings for:
  - `,gb`: git blame for current line.
  - `[h`: go to previous diff hunk.
  - `]h`: go to previous diff hunk.
- `nvim-colorizer` to highlight hex color definitions.
- `nvim-comment` with `nvim-ts-context-commentstring` for setting correct
  comment type depending on context.
- `nvim-lastplace` for opening files at last edit position.
- `mkdir` for creating missing directories when saving files.
- [mkdnflow](lua/plugins/mkdnflow.lua) with most modules disabled except for
  intelligent list continuation with `Enter` and todo state manipulation
  (`C-Space`).
- [lsp](lua/plugins/lsp.lua) with mappings for:
  - `gd`: go to definition.
  - `gr`: rename.
  - `K`: show symbol info.
- [lspconfig](lua/plugins/lspconfig.lua) setup for `pylsp`, `gopls` and
  `sumneko`.
- [null-ls](lua/plugins/null-ls.lua) with:
  - Python formatting: `black` and `isort`.
  - Lua formatting: `stylua`.
  - Markdown formatting: `deno`.
  - Shell formatting and diagnostics: `shfmt` and `shellcheck`.
  - Go formatting: `gofmt`.
  - Django/Jinja2 formatting: `djhtml`.
- [cmp](lua/plugins/cmp.lua) for non-automatic completion with `Tab` for
  `path`, `lsp` and `buffer` sources.

[gh-theme]: https://github.com/projekt0n/github-nvim-theme
