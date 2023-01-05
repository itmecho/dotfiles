local actions = require('telescope.actions')
local state = require('telescope.actions.state')
local finders = require('telescope.finders')
local pickers = require('telescope.pickers')
local sorters = require('telescope.sorters')
local iutils = require('itmecho.utils')

local M = {}

M.fixup = function()
  -- TODO check if there are staged changes
  M.pick_commit({
    callback = function(commit_hash)
      vim.fn.system('git commit --fixup ' .. commit_hash)
    end,
  })
end

M.pick_commit = function(opts)
  opts = vim.tbl_deep_extend('keep', opts or {}, {
    limit = 20,
  })
  local git_log = vim.fn.system('git log --oneline | head -' .. opts.limit)
  local commits = {}
  for line in git_log:gmatch('[^\r\n]+') do
    table.insert(commits, line)
  end
  pickers.new({}, {
    prompt_title = 'Commit to fixup',
    finder = finders.new_table({
      results = commits,
      entry_maker = function(entry)
        local commit_hash = entry:match('(%w+)(.+)')
        return {
          value = commit_hash,
          display = entry,
          ordinal = commit_hash,
        }
      end,
    }),
    sorter = sorters.get_fzy_sorter(),
    attach_mappings = function(bufnr)
      actions.select_default:replace(function()
        actions.close(bufnr)
        local selection = state.get_selected_entry()
        if opts.callback ~= nil then
          opts.callback(selection.value)
        end
      end)
      return true
    end,
  }):find()
end

return M
