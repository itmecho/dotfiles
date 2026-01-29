local Path = require('plenary.path')

local initial_open = true

local M = {}

function M.setup(opts)
  opts = vim.tbl_deep_extend('keep', opts or {}, {
    max_depth = 3,
  })
  if not opts.root then
    error('opts.root is required')
  end
  M._root = opts.root
  M._max_depth = opts.max_depth
end

function M.open(dir, new_tab)
  if new_tab then
    vim.cmd.tabnew()
  end
  vim.cmd('tcd ' .. M.get_root_dir())
  vim.cmd('tcd ' .. dir)
end

function M.get_root_dir()
  if type(M._root) == 'function' then
    return M._root()
  end
  return M._root
end

function M.new()
  local opts = { cwd = M.get_root_dir() }
  local pickers = require('telescope.pickers')
  local finders = require('telescope.finders')
  local conf = require('telescope.config').values
  local actions = require('telescope.actions')
  local action_state = require('telescope.actions.state')

  local output_1 = vim.fn.system({
    'fd',
    'main.go|package.json',
    '--base-directory',
    Path:new(opts.cwd):expand(),
  })
  local output_2 = vim.fn.system({
    'fd',
    '--type',
    'd',
    '--max-depth',
    M._max_depth,
    '--base-directory',
    Path:new(opts.cwd):expand() .. '/lib',
  })
  local dirs = {}
  for _, dir in ipairs(vim.split(output_1, '\n')) do
		dir = string.gsub(dir, '/main.go', '')
		dir = string.gsub(dir, '/package.json', '')
    table.insert(dirs, dir)
  end
  for _, dir in ipairs(vim.split(output_2, '\n')) do
    table.insert(dirs, 'lib/'..dir)
  end

  local finder = finders.new_table(dirs)

  pickers
    .new(opts, {
      debounce = 100,
      prompt_title = 'Project',
      finder = finder,
      previewer = conf.grep_previewer(opts),
      sorter = require('telescope.sorters').get_generic_fuzzy_sorter(),
      attach_mappings = function(bufnr, map)
        map('i', '<cr>', function()
          actions.close(bufnr)
          local dir = action_state.get_selected_entry()[1]
          M.open(dir, not initial_open)
          initial_open = false
        end)
        map('i', '<c-o>', function()
          actions.close(bufnr)
          local dir = action_state.get_selected_entry()[1]
          M.open(dir, false)
          initial_open = false
        end)
        return true
      end,
    })
    :find()
end

return M
