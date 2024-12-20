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
