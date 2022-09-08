local actions = require('telescope.actions')
local state = require('telescope.actions.state')
local tb = require('telescope.builtin')
local generic_picker = require('itmecho.utils.telescope').generic_picker

local iutils = require('itmecho.utils')

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

M.find_proto = function()
  generic_picker({
    prompt_title = 'Find Proto',
    command = [[fd '\.proto$' apis]],
    cwd = '~/src/CloudExperiments',
  })
end

M.orca = function()
  generic_picker({
    prompt_title = 'Orca',
    command = [[rg -o -r '$1' --no-line-number '".+": "//.+:(.+).image"' BUILD.bazel | sort | uniq]],
    cwd = '~/src/CloudExperiments',
    mappings = function(prompt_bufnr, map)
      map('i', '<cr>', function()
        actions.close(prompt_bufnr)
        iutils.run_in_term(1, 'orca variant update ' .. state.get_selected_entry().value)
      end)
      map('i', '<c-d>', function()
        actions.close(prompt_bufnr)
        iutils.run_in_term(1, 'orca variant update -v default --allow-default ' .. state.get_selected_entry().value)
      end)
      map('i', '<C-l>', function()
        actions.close(prompt_bufnr)
        iutils.run_in_term(1, 'orca variant logs ' .. state.get_selected_entry().value)
      end)
      return true
    end,
  })
end

return M
