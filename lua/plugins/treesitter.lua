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
        'go',
        'gomod',
        'help',
        'hcl',
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
        -- Disabled until generation from grammar is not needed: 'sql',
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
          'python',
          'toml',
        },
      },
      yati = { enable = true },
      context_commentstring = { enable = true, enable_autocmd = false },
    })

    require('vim.treesitter.query').set_query(
      'markdown_inline',
      'highlights',
      [[
  ;; From MDeiml/tree-sitter-markdown
  [
    (code_span)
    (link_title)
  ] @text.literal

  [
    (emphasis_delimiter)
    (code_span_delimiter)
  ] @punctuation.delimiter

  (emphasis) @text.emphasis

  (strong_emphasis) @text.strong

  [
    (link_destination)
    (uri_autolink)
  ] @text.uri

  [
    (link_label)
    (link_text)
    (image_description)
  ] @text.reference

  [
    (backslash_escape)
    (hard_line_break)
  ] @string.escape

  ; "(" not part of query because of
  ; https://github.com/nvim-treesitter/nvim-treesitter/issues/2206
  ; TODO: Find better fix for this
  (image ["!" "[" "]" "("] @punctuation.delimiter)
  (inline_link ["[" "]" "("] @punctuation.delimiter)
  ; Disabled so that ending punctuation for @text.mark.* below works:
  ; (shortcut_link ["[" "]"] @punctuation.delimiter)

  ([
    (code_span_delimiter)
    (emphasis_delimiter)
  ] @conceal
  (#set! conceal ""))

  ; Conceal inline links
  (inline_link
    [
      "["
      "]"
      "("
      (link_destination)
      ")"
    ] @conceal
    (#set! conceal ""))

  ; Conceal image links
  (image
    [
      "!"
      "["
      "]"
      "("
      (link_destination)
      ")"
    ] @conceal
    (#set! conceal ""))

  ; Conceal full reference links
  (full_reference_link
    [
      "["
      "]"
      (link_label)
    ] @conceal
    (#set! conceal ""))

  ; Conceal collapsed reference links
  (collapsed_reference_link
    [
      "["
      "]"
    ] @conceal
    (#set! conceal ""))

  ; Conceal shortcut links (disabled)
  ;(shortcut_link
  ;  [
  ;    "["
  ;    "]"
  ;  ] @conceal
  ;  (#set! conceal ""))

  (shortcut_link
    (link_text) @text.mark.pending
    (#eq? @text.mark.pending "-")
  ) @text.mark.pending

  (shortcut_link
    (link_text) @text.mark.moved
    (#eq? @text.mark.moved ">")
  ) @text.mark.moved
]]
    )
  end,
}
