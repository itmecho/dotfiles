local initial_open = true

--- @class MonoOptions
--- @field root string|function The root directory of the monorepo or a function that returns the same.
--- @field get_options function A function that returns a list of directories that should be treated as projects within the monorepo.
--- @field tabline boolean The root directory of the monorepo.

local M = {}

--- @param opts MonoOptions
function M.setup(opts)
  opts = vim.tbl_deep_extend('keep', opts or {}, {
    tabline = false,
  })
  if not opts.root then
    error('opts.root is required')
  end
  if not opts.get_options or type(opts.get_options) ~= 'function' then
    error('opts.get_options is required and must be a function')
  end
  M._root = opts.root
  M._get_options = opts.get_options

  if opts.tabline then
    vim.opt.tabline = '%!v:lua.MonoTabLine()'
  end
end

function M.open(dir, reuse_current_tab)
  if not reuse_current_tab then
    vim.cmd.tabnew()
  end
  vim.cmd('tcd ' .. M.get_root_dir())
  vim.cmd('tcd ' .. dir)
  vim.api.nvim_tabpage_set_var(0, 'mono_dir', vim.fn.fnamemodify(dir, ':t'))
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

  local finder = finders.new_table(M._get_options())

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
          M.open(dir, initial_open)
          initial_open = false
        end)
        map('i', '<c-o>', function()
          actions.close(bufnr)
          local dir = action_state.get_selected_entry()[1]
          M.open(dir, true)
          initial_open = false
        end)
        return true
      end,
    })
    :find()
end

function _G.MonoTabLine()
  local tabs = vim.api.nvim_list_tabpages()
  local current_tab = vim.api.nvim_get_current_tabpage()

  local s = ''
  for _, tab in ipairs(tabs) do
    local has_mono_dir, tabdir = pcall(vim.api.nvim_tabpage_get_var, tab, 'mono_dir')
    if tab == current_tab then
      s = s .. '%#TabLineSel#'
    else
      s = s .. '%#TabLine#'
    end
    if has_mono_dir then
      s = s .. ' ' .. tabdir .. ':'
    end
    s = s .. ' %t '
  end
  return s
end

function M.tabline()
  return MonoTabLine()
end

return M
