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
  - `,gc`: git commit and sync.
  - `,e`: edit in working directory of current file.
  - `[d`: previous diagnostic.
  - `]d`: next diagnostic.
  - `gl`: view diagnostic.

## Custom plugins

- [gh](lua/gh.lua): custom GitHub based color scheme (slight differences from
  the popular [projekt0n/github-nvim-theme][gh-theme]).

## Other plugins

- [which-key](lua/plugins/which-key.lua) with spelling suggestions (`z=`).
- [treesitter](lua/plugins/treesitter.lua) with custom queries for pending
  (`- [-]`) and moved (`- [>]`) todo items.
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
- `mini.comment` with `nvim-ts-context-commentstring` for setting correct
  comment type depending on context.
- `nvim-lastplace` for opening files at last edit position.
- `mkdir` for creating missing directories when saving files.
- [lsp](lua/plugins/lsp.lua) with mappings for:
  - `gd`: go to definition.
  - `,lr`: rename.
  - `,lc`: code action.
  - `K`: show symbol info.
- [lspconfig](lua/plugins/lspconfig.lua) setup for `pylsp`,`gopls` and
  `lua-language-server`.
- [null-ls](lua/plugins/null-ls.lua) with:
  - Lua formatting: `stylua`.
  - Shell formatting and diagnostics: `shfmt` and `shellcheck`.
  - Go formatting: `gofmt`.
- [cmp](lua/plugins/cmp.lua) for non-automatic completion with `Tab` for
  `path`, `lsp` and `buffer` sources.

[gh-theme]: https://github.com/projekt0n/github-nvim-theme
