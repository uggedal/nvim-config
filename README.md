# Neovim config

Neovim config in lua.

## Configuration

- [settings](lua/settings.lua): tweak built-in settings.
- [languages](lua/languages.lua): spaces vs tab indent setup, text wrapping,
  line numbering and conceal for different languages.
- [keymaps](lua/keymaps.lua): definition and re-definition of built-in
  mappings:
  - `<C-l>`: clear screen (original) and clear search highlight.
  - `,cp`: paste from system clipboard.
  - `,cy`: yank to system clipboard (visual mode).
  - `,p`: previous buffer.
  - `,n`: next buffer.
  - `,d`: delete buffer.
  - `,i`: toggle paste mode.
  - `,gc`: git commit and sync.
  - `,e`: edit in working directory of current file.
  - `[d`: previous diagnostic.
  - `]d`: next diagnostic.
  - `gl`: view diagnostic.

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
- [telescope](lua/plugins/telescope.lua) with `telescope-fzf-native` with
  mappings for:
  - `<C-p>`: finding files
  - `<C-g`: live grep
  - `,gl`: list git commits of current file.
  - `,gL`: list all git commits.
  - `,gB`: list git branches.
  - `,gs`: show git status
  - `gr`: list lsp references
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
- `peek` for live markdown previews using `:PeekOpen` and `:PeekClose`.
- [lsp](lua/plugins/lsp.lua) with mappings for:
  - `gd`: go to definition.
  - `,lr`: rename.
  - `,lc`: code action.
  - `K`: show symbol info.
- [lspconfig](lua/plugins/lspconfig.lua) setup for `jedi`, `ruff-lsp` `gopls`
  and `lua-language-server`.
- [null-ls](lua/plugins/null-ls.lua) with:
  - Python formatting and diagnostics: `black` and `mypy`.
  - Lua formatting: `stylua`.
  - Markdown formatting: `deno`.
  - Shell formatting and diagnostics: `shfmt` and `shellcheck`.
  - Go formatting: `gofmt`.
- [cmp](lua/plugins/cmp.lua) for non-automatic completion with `Tab` for
  `path`, `lsp` and `buffer` sources.

## TODO

- [ ] Find alternative to `buftabline` as it's abandoned upstream:
  - Potentially [cybu][cybu].
- [ ] Plugins to consider:
  - [ ] [telescope-frequency]
  - [ ] [telescope-undo]
  - [ ] [neogit]
  - [ ] [nvim-surround]
  - [ ] [vim-illuminate]
  - [ ] [nvim-treesitter-textobjects]
  - [ ] [nvim-treesitter-textsubjects]
  - [ ] [nvim-navic]
  - [ ] [telescope-heading]
  - [ ] [telescope-ui-select]
- [ ] Check [kickstart.nvim][kickstart.nvim].
- [ ] `journal`: create calendar (use/reuse
      [neorg implementation](neorg-calendar)).
- [ ] Create [clipboard-image][clipboard-image] alternative using
      `screencapture -i %s`.

[gh-theme]: https://github.com/projekt0n/github-nvim-theme
[cybu]: https://github.com/ghillb/cybu.nvim
[telescope-frequency]: https://github.com/nvim-telescope/telescope-frecency.nvim
[telescope-undo]: https://github.com/debugloop/telescope-undo.nvim
[neogit]: https://github.com/TimUntersberger/neogit
[nvim-surround]: https://github.com/kylechui/nvim-surround
[vim-illuminate]: https://github.com/RRethy/vim-illuminate
[nvim-treesitter-textobjects]: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
[nvim-treesitter-textsubjects]: https://github.com/RRethy/nvim-treesitter-textsubjects
[nvim-navic]: https://github.com/SmiteshP/nvim-navic
[telescope-heading]: https://github.com/crispgm/telescope-heading.nvim
[telescope-ui-select]: https://github.com/nvim-telescope/telescope-ui-select.nvim
[kickstart.nvim]: https://github.com/nvim-lua/kickstart.nvim
[neorg-calendar]: https://github.com/nvim-neorg/neorg/pull/505
[clipboard-image]: https://github.com/ekickx/clipboard-image.nvim
