-- Global print function for debugging, mainly tables
function P(v)
  print(vim.inspect(v))
end

-- Global function to force reload a module if it's already in the cache
function R(module)
  package.loaded[module] = nil
  return require(module)
end

-- Leaders
vim.g.mapleader = ' '
vim.g.maplocalleader = ','

-- Settings
vim.opt.cursorline = true
vim.opt.hlsearch = true
vim.opt.laststatus = 3
vim.opt.mouse = ''
vim.opt.number = true
vim.opt.foldenable = false
vim.opt.relativenumber = true
vim.opt.smartcase = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.signcolumn = 'yes'
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.undolevels = 10000
vim.opt.updatetime = 200
vim.opt.winbar = "%=%{fnamemodify(getcwd(), ':t')}: %f%m"
vim.opt.winborder = 'rounded'

-- Default indentation 2 spaces
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2

-- Keymaps
local ucmd = require('itmecho.util.cmd')
local nopts = function(desc)
  return { silent = true, noremap = true, desc = desc }
end

vim.keymap.set('n', '<esc>', '<esc>:noh<cr>', nopts('Clear search highlight on Escape'))
-- Center search results
for _, lhs in ipairs({ 'n', 'N', '}', '{', '<c-d>', '<c-u>' }) do
  vim.keymap.set('n', lhs, lhs .. 'zz', nopts(string.format('Vertical center after %s', lhs)))
end
vim.keymap.set('n', '<leader>Sg', function()
  ucmd.float_cmd('spxdev gen gazelle', { title = 'Gazelle' })
end, nopts('Generate gazelle in a floating window'))

vim.keymap.set('n', '<leader>Sp', function()
  ucmd.float_cmd('spxdev gen proto', { title = 'Proto' })
end, nopts('Generate gazelle and proto in a floating window'))

vim.keymap.set('n', '<leader>SP', function()
  ucmd.float_cmd('spxdev gen gazelle && spxdev gen proto', { title = 'Gazelle & Proto' })
end, nopts('Generate proto in a floating window'))

vim.keymap.set('v', '<leader>y', '"+y', { desc = 'Copy selection to system clipboard' })
vim.keymap.set('v', '>', '>gv', { desc = 'Reselect after right shift' })
vim.keymap.set('v', '<', '<gv', { desc = 'Reselect after leftright shift' })

vim.keymap.set('n', '<leader>g', function()
  ucmd.tmux_popup('lazygit')
end, nopts('Open lazygit in a tmux popup'))

-- Diagnostics
vim.diagnostic.config({
  jump = {
    float = true,
    wrap = true,
  },
})
