local tb = require('telescope.builtin')
local actions = require('telescope.actions')
local finders = require('telescope.finders')
local pickers = require('telescope.pickers')
local previewers = require('telescope.previewers')
local sorters = require('telescope.sorters')
local state = require('telescope.actions.state')

local M = {}

M.generic_picker = function(opts)
  local items = {}

  if opts.items ~= nil then
    items = opts.items
  elseif opts.command then
    local cmd = 'cd ' .. opts.cwd .. '; ' .. opts.command
    items = vim.fn.systemlist(cmd)
  else
    print('No command or items provided')
    return
  end

  pickers.new({}, {
    prompt_title = opts.prompt_title,
    cwd = opts.cwd,
    finder = finders.new_table(items),
    previewer = previewers.vim_buffer_cat.new({}),
    sorter = sorters.get_fzy_sorter(),
    attach_mappings = opts.mappings,
  }):find()
end

M.search_nvim_config = function()
  tb.find_files({ prompt_title = 'Neovim Config', cwd = '~/.config/nvim' })
end

M.file_browser = function()
  tb.file_browser({
    hidden = true,
    attach_mappings = function(_, map)
      map('i', '<c-d>', function()
        local path = state.get_selected_entry().value
        vim.cmd('tcd ' .. path)
        print('changed directory to ' .. path)
      end)
      return true
    end,
  })
end

M.buffers = function()
  tb.buffers({
    attach_mappings = function(_, map)
      map('i', '<c-d>', function(_)
        local selection = state.get_selected_entry()
        if pcall(vim.api.nvim_buf_delete, selection.bufnr, {}) then
          print(string.format('Deleted buffer %d: %s', selection.bufnr, selection.filename))
          -- Delete buffer here
        end
      end)
      return true
    end,
  })
end

M.open_web = function()
  M.generic_picker({
    items = { 'https://play.golang.org' },
    prompt_title = 'Open New Tab',
    mappings = function(prompt_bufnr, map)
      map('i', '<cr>', function()
        local url = state.get_selected_entry().value
        print('opening ' .. url)
        vim.cmd('silent !firefox --new-tab ' .. url)
        actions.close(prompt_bufnr)
      end)
      return true
    end,
  })
end

return M
