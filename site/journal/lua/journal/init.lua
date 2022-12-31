local config = {
  journaldir = '',
}

local is_in_journal_dir = function()
  return vim.fn.isdirectory(config.journaldir) == 1
    and vim.fn.getcwd() == vim.fs.dirname(config.journaldir)
end

local DAY = 24 * 60 * 60

local rg_sort_args = {
  '--sortr',
  'path',
}

local rg_defaults = {
  'rg',
  '--color',
  'never',
  '--files',
  '--type',
  'markdown',
}

vim.list_extend(rg_defaults, rg_sort_args)

local previous_journal_path = function(time)
  local max_lookbehind = time - 7 * DAY

  while time >= max_lookbehind do
    time = time - DAY
    local day = os.date('%Y-%m-%d', time)
    local path = config.journaldir .. '/' .. day .. '.md'
    if vim.fn.filereadable(path) ~= 0 then
      return path
    end
  end

  return nil
end

local journal_on_day = function(time, prompt_title)
  if not is_in_journal_dir() then
    print('Not in correct dir: ' .. vim.fs.dirname(config.journaldir))
    return
  end

  local day = os.date('%Y-%m-%d', time)
  local path = config.journaldir .. '/' .. day .. '.md'

  if vim.fn.filereadable(path) == 0 then
    local previous_path = previous_journal_path(time)
    local previous_content = {}
    local open_tasks = {}
    local below_h2 = false

    if previous_path ~= nil then
      for line in io.lines(previous_path) do
        -- Stop copying incomplete task at first level 2 heading:
        if line:match('^##') ~= nil then
          below_h2 = true
        end

        local should_migrate_below_h2_line = false
        local is_pending_todo_line = line:match('^%s*- %[[ -]%]')

        if below_h2 and is_pending_todo_line then
          vim.ui.input({
            prompt = 'Migrate: '
              .. string.gsub(line, '^%s*- %[[ -]%] ', '')
              .. ' [y/n]: ',
          }, function(input)
            should_migrate_below_h2_line = input == 'y'
          end)
        end

        if
          (not below_h2 and is_pending_todo_line)
          or should_migrate_below_h2_line
        then
          table.insert(open_tasks, line)
          local migrated_line, _ = string.gsub(line, '- %[[ -]%]', '- [>]')
          table.insert(previous_content, migrated_line)
        else
          table.insert(previous_content, line)
        end
      end
    end

    local newf = io.open(path, 'a')
    if newf ~= nil then
      newf:write('# ' .. day .. ' ' .. os.date('%A', time) .. '\n\n')
      for _, open_task in ipairs(open_tasks) do
        newf:write(open_task .. '\n')
      end
      newf:flush()
      newf:close()
    end

    if previous_path ~= nil then
      local oldf = io.open(previous_path, 'w')
      if oldf ~= nil then
        for _, line in ipairs(previous_content) do
          oldf:write(line .. '\n')
        end
        oldf:flush()
        oldf:close()
      end
    end
  end
  return require('telescope.builtin').find_files({
    prompt_title = prompt_title,
    cwd = config.journaldir,
    default_text = day,
    find_command = rg_defaults,
  })
end

return {
  journal_today = function()
    return journal_on_day(os.time(), "Open today's journal entry")
  end,

  journal_tomorrow = function()
    return journal_on_day(os.time() + DAY, "Open tomorrow's journal entry")
  end,

  journal_find = function()
    if not is_in_journal_dir() then
      print('Not in correct dir: ' .. vim.fs.dirname(config.journaldir))
      return
    end
    return require('telescope.builtin').find_files({
      prompt_title = 'Find journal entries',
      cwd = config.journaldir,
      find_command = rg_defaults,
    })
  end,

  setup = function(new_config)
    new_config = new_config or {}
    config = vim.tbl_extend('force', config, new_config)
  end,
}
