local c = require('gh.colors')

return {
  ['@variable'] = { fg = c.fg_1 },
  Identifier = { link = '@variable' },
  ['@field'] = { fg = c.fg_1 },
  ['@property'] = { fg = c.blue_1 },
  ['@label'] = { fg = c.fg_1 },
  Label = { link = '@label' },

  ['@type'] = { fg = c.brown_1 },
  Type = { link = '@type' },
  ['@type.definition'] = { fg = c.brown_1 },
  ['@type.builtin'] = { fg = c.fg_1 },
  ['@attribute'] = { fg = c.purple_1 },
  ['@constant'] = { fg = c.brown_1 },
  Constant = { link = '@constant' },
  ['@constant.builtin'] = { fg = c.blue_1 },
  ['@constant.macro'] = { fg = c.red_1 },

  ['@include'] = { fg = c.red_1 },
  Include = { link = '@include' },
  ['@keyword'] = { fg = c.red_1 },
  Keyword = { link = '@keyword' },
  Statement = { link = '@keyword' },
  ['@keyword.operator'] = { fg = c.blue_1 },
  ['@operator'] = { fg = c.blue_1 },
  Operator = { link = '@operator' },
  ['@conditional'] = { fg = c.red_1 },
  Conditional = { link = '@conditional' },
  ['@repeat'] = { fg = c.red_1 },
  Repeat = { link = '@repeat' },
  ['@exception'] = { fg = c.red_1 },
  Exception = { link = '@exception' },
  -- Shebang and c preprocessor, style for the former:
  ['@preproc'] = { link = '@comment' },
  PreProc = { link = '@preproc' },
  -- c #define:
  ['@define'] = { fg = c.red_1 },
  Define = { link = '@define' },

  ['@method'] = { fg = c.purple_1 },
  ['@method.call'] = { fg = c.purple_1 },
  ['@function'] = { fg = c.purple_1 },
  Function = { link = '@function' },
  ['@function.builtin'] = { fg = c.purple_1 },
  ['@function.call'] = { fg = c.purple_1 },
  -- c preprocessor function name:
  ['@function.macro'] = { fg = c.purple_1 },
  ['@parameter'] = { fg = c.fg_1 },
  ['@constructor'] = { fg = c.brown_1 },
  Special = { link = '@constructor' },
  -- go package identifier and rust use identifier:
  ['@namespace'] = { fg = c.fg_1 },
  -- c extern/static/auto/register/inline:
  ['@storageclass'] = { fg = c.red_1 },

  ['@number'] = { fg = c.blue_1 },
  Number = { link = '@number' },
  ['@float'] = { fg = c.blue_1 },
  Float = { link = '@float' },
  ['@string'] = { fg = c.blue_0 },
  String = { link = '@string' },
  ['@string.escape'] = { fg = c.blue_0 },
  -- vim help keycode:
  ['@string.special'] = { fg = c.purple_1 },
  ['@character'] = { fg = c.blue_0 },
  Character = { link = '@character' },
  ['@character.special'] = { fg = c.red_1 },
  ['@boolean'] = { fg = c.blue_1 },
  Boolean = { link = '@boolean' },

  ['@punctuation'] = { fg = c.fg_1 },
  Delimiter = { link = '@punctuation' },
  ['@punctuation.bracket'] = { fg = c.fg_1 },
  ['@punctuation.special'] = { fg = c.fg_1 },
  ['@punctuation.delimiter'] = { fg = c.fg_1 },

  ['@comment'] = { fg = c.fg_2, italic = true },
  Comment = { link = '@comment' },

  ['@text.todo'] = { fg = c.fg_2, bold = true },
  Todo = { link = '@text.todo' },
  ['@text.todo.unchecked'] = { fg = c.fg_2 },
  ['@text.todo.checked'] = { fg = c.fg_2 },
  ['@text.todo.pending'] = { fg = c.green_1 },
  ['@text.todo.moved'] = { fg = c.purple_1 },
  ['@text.title'] = { fg = c.blue_1, bold = true },
  ['@text.literal'] = { fg = c.blue_1 },
  ['@text.strong'] = { bold = true },
  ['@text.emphasis'] = { italic = true },
  ['@text.reference'] = { fg = c.purple_1 },
  ['@text.uri'] = { fg = c.blue_1 },
  ['@text.underline'] = { underline = true },
  Underlined = { link = '@text.underline' },

  ['@tag'] = { fg = c.green_1 },

  ['@text.diff.add'] = { bg = c.green_bg },
  ['@text.diff.delete'] = { bg = c.red_bg },

  -- toml
  ['@type.toml'] = { fg = c.purple_1 },
  ['@property.toml'] = { fg = c.fg_1 },
  ['@string.special.toml'] = { fg = c.blue_1 },

  -- Currently unused in nvim highlights:
  -- @class
  -- @debug
  -- @decorator
  -- @enum
  -- @enumMember
  -- @event
  -- @interface
  -- @macro
  -- @modifier
  -- @punctuation
  -- @regexp
  -- @struct
  -- @text.underline
  -- @typeParameter
}
