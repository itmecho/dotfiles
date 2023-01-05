local actions = require('telescope.actions')
local state = require('telescope.actions.state')
local tb = require('telescope.builtin')

local M = {}

M.cd_to_project = function()
  tb.find_files({
    prompt_title = 'Sparx Projects',
    cwd = '~/src/CloudExperiments',
    find_command = { 'fd', '--max-depth=3', '--type=d' },
    attach_mappings = function(prompt_bufnr, map)
      map('i', '<cr>', function()
        local path = '~/src/CloudExperiments/' .. state.get_selected_entry().value
        vim.cmd('tcd ' .. path)
        actions.close(prompt_bufnr)
        local parts = vim.fn.split(path, '/')
        vim.g.itmecho_project = parts[#parts]
        print('project: ' .. path)
      end)
      return true
    end,
  })
end

return M
