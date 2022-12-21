# Neovim config

Neovim config in lua.

## Custom plugins

- [gh](lua/gh.lua): custom GitHub based color scheme.
- [journal](lua/journal.lua): markdown based daily journal with task migration:
  - `,jt`: open or create journal for today.
  - `,jm`: open or create journal for tomorrow.
  - `,jf`: find a journal entry.
- [todo](lua/todo.lua): TODO item handler:
  - `,to`: find open or pending TODO items.
  - `,td`: find done TODO items.
  - `,tm`: find migrated TODO items.

## Configured plugins

- [cmp](lua/plugins/cmp.lua)
- [gitsigns](lua/plugins/gitsigns.lua)
- [lsp](lua/plugins/lsp.lua)
- [lspconfig](lua/plugins/lspconfig.lua)
- [lspconfig](lua/plugins/lspconfig.lua)
- [mkdnflow](lua/plugins/mkdnflow.lua)
- [null-ls](lua/plugins/null-ls.lua)
- [telescope](lua/plugins/telescope.lua)
