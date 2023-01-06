local c = require('gh.colors')
return {
  -- Telescope
  TelescopeBorder = { fg = c.bg_2 },
  TelescopeMatching = { fg = c.red_1 },
  TelescopePromptPrefix = { fg = c.fg_1 },

  -- Gitsigns
  GitSignsAddNr = { bg = c.green_bg },
  GitSignsChangeNr = { bg = c.yellow_2 },
  GitSignsDeleteNr = { bg = c.red_bg },

  -- Which Key
  WhichKey = { fg = c.red_1, bold = true },
  WhichKeyGroup = { fg = c.fg_1 },
  WhichKeySeparator = { fg = c.fg_1 },
  WhichKeyDesc = { fg = c.fg_1 },
  WhichKeyFloat = { bg = c.bg_1 },

  -- LSP Config
  LspInfoBorder = { fg = c.bg_2 },

  -- Null Ls
  NullLsInfoBorder = { fg = c.bg_2 },
}
