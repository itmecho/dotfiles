local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = ' '
vim.g.maplocalleader = ','

vim.filetype.add({ extension = { templ = 'templ' } })

require('lazy').setup({
  spec = {
    { import = 'plugins' },
  },
})

require('itmecho.global')
require('itmecho.settings')
require('itmecho.keymaps')
require('itmecho.ft-settings')

require('itmecho.commands')

local mono = require('itmecho.mono')
mono.setup({
  root = function()
    return vim.trim(vim.fn.system('git rev-parse --show-toplevel'))
  end,
  get_options = function()
    local dirs = {}

    local js_dirs = vim.fn.system('sh -c "cd $CLOUDPATH && fd package.json | xargs dirname"')
    for _, dir in ipairs(vim.split(js_dirs, '\n')) do
      if dir ~= '.' then
        table.insert(dirs, dir)
      end
    end

    local go_dirs = vim.fn.system('sh -c "cd $CLOUDPATH && fd BUILD.bazel | xargs rg go_binary -l | xargs dirname"')
    for _, dir in ipairs(vim.split(go_dirs, '\n')) do
      if dir ~= '.' then
        table.insert(dirs, dir)
      end
    end

    return dirs
  end,
  tabline = true,
})

vim.keymap.set('n', '<leader>po', mono.new)

vim.cmd.cnoreabbrev('Qa', 'qa')
vim.cmd.cnoreabbrev('Q', 'q')
vim.cmd.cnoreabbrev('Wq', 'Wq')

vim.api.nvim_create_autocmd('User', {
  pattern = 'ConformFormatPre',
  callback = function(event)
    print('running ' .. event.data.formatter.name)
  end,
})

vim.api.nvim_create_autocmd('User', {
  pattern = 'ConformFormatPost',
  callback = function(event)
    if event.data.err ~= nil then
      print(string.format('%s failed (%d): %s', event.data.formatter.name, event.data.err.code, event.data.err.message))
    else
      print(string.format('finished running %s', event.data.formatter.name))
    end
  end,
})
