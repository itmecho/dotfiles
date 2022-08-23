local tb = require('telescope.builtin')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local finders = require('telescope.finders')
local pickers = require('telescope.pickers')
local previewers = require('telescope.previewers')
local sorters = require('telescope.sorters')
local state = require('telescope.actions.state')

local neoterm = require('neoterm')
local iutils = require('itmecho.utils')

local M = {}

M.generic_picker = function(opts)
  local items = {}

  if opts.items ~= nil then
    items = opts.items
  elseif opts.command then
    local results = vim.fn.system(opts.command)
    for s in results:gmatch('[^\r\n]+') do
      table.insert(items, s)
    end
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

M.orca = function()
  M.generic_picker({
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

M.gotest = function()
  M.generic_picker({
    prompt_title = 'Filter test packages',
    command = 'fd _test.go --exec echo {//} | sort | uniq;',
    mappings = function(prompt_bufnr, map)
      map('i', '<cr>', function()
        actions.close(prompt_bufnr)
        neoterm.run('go test ./' .. state.get_selected_entry().value .. '/...')
      end)
      return true
    end,
  })
end

M.search_string = function()
  tb.grep_string({
    prompt_title = 'Filter Results',
    search = vim.fn.input('Search for: '),
  })
end

M.search_nvim_config = function()
  tb.find_files({ prompt_title = 'Neovim Config', cwd = '~/.config/nvim' })
end

M.cd_to_project = function()
  tb.find_files({
    prompt_title = 'Sparx Projects',
    cwd = '~/src/CloudExperiments',
    find_command = { 'fd', '--max-depth=3', '--type=d' },
    attach_mappings = function(prompt_bufnr, map)
      map('i', '<cr>', function(bufnr)
        local path = '~/src/CloudExperiments/' .. state.get_selected_entry(bufnr).value
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

M.file_browser = function()
  tb.file_browser({
    hidden = true,
    attach_mappings = function(_, map)
      map('i', '<c-d>', function(bufnr)
        local path = state.get_selected_entry(bufnr).value
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
        local selection = action_state.get_selected_entry()
        if opts.callback ~= nil then
          opts.callback(selection.value)
        end
      end)
      return true
    end,
  }):find()
end

return M
