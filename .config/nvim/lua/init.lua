require 'plugins'
require 'options'
vim.g.mapleader = ' '

vim.cmd('filetype plugin indent on')
vim.cmd('syntax on')
vim.cmd('colorscheme dracula')

require 'lsp'
require 'binds'
