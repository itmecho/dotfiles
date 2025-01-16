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

vim.filetype.add({ extension = { templ = "templ" } })

require('lazy').setup('plugins')

require('itmecho.global')
require('itmecho.settings')
require('itmecho.keymaps')
require('itmecho.ft-settings')

require('itmecho.commands')

vim.cmd.cnoreabbrev('Qa', 'qa')
vim.cmd.cnoreabbrev('Q', 'q')
vim.cmd.cnoreabbrev('Wq', 'Wq')

vim.api.nvim_create_autocmd("User", {
  pattern = 'ConformStartFormat',
  callback = function(event)
    print('running ' .. event.data.formatter.name)
  end
})

vim.api.nvim_create_autocmd("User", {
  pattern = 'ConformEndFormat',
  callback = function(event)
    print(string.format('finished running %s: exitcode=%s', event.data.formatter.name, event.data.code))
  end
})
