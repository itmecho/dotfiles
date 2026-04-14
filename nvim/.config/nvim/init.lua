-- Global print function for debugging, mainly tables
function P(v)
  print(vim.inspect(v))
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

vim.g.zig_fmt_autosave = 0

-- Keymaps
local nopts = { silent = true, noremap = true }

vim.keymap.set('n', '<esc>', '<esc>:noh<cr>', nopts)
-- Center search results
for _, lhs in ipairs({ 'n', 'N', '}', '{', '<c-d>', '<c-u>' }) do
  vim.keymap.set('n', lhs, lhs .. 'zz', nopts)
end
vim.keymap.set('n', '<leader>Sg', function()
  require('itmecho.util.cmd').float_cmd('spxdev gen gazelle', { title = 'Gazelle' })
end)
vim.keymap.set('n', '<leader>Sp', function()
  require('itmecho.util.cmd').float_cmd('spxdev gen proto', { title = 'Proto' })
end)
vim.keymap.set('n', '<leader>SP', function()
  require('itmecho.util.cmd').float_cmd('spxdev gen gazelle && spxdev gen proto', { title = 'Gazelle & Proto' })
end)

-- Diagnostics
vim.diagnostic.config({
  jump = {
    float = true,
    wrap = true,
  },
})
