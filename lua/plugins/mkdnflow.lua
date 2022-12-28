return {
  init = function(mkdnflow)
    mkdnflow.setup({
      modules = {
        bib = false,
        buffers = false,
        conceal = false,
        cursor = false,
        folds = false,
        links = false,
        paths = false,
        tables = true,
      },
      to_do = {
        symbols = { ' ', '-', 'x' },
        update_parents = false,
      },
      mappings = {
        MkdnUpdateNumbering = false,
        MkdnEnter = { { 'i' }, '<CR>' },
      },
    })
  end,
}
