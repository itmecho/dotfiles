vim.keymap.set('n', '<leader>fd', vim.cmd.Ex)

-- QoL
vim.keymap.set('n', '<esc>', '<cmd>noh<CR><esc>')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-h>', '<cmd>tabprevious<cr>')
vim.keymap.set('n', '<C-l>', '<cmd>tabnext<cr>')
vim.keymap.set('n', '<leader>y', '"+y')
vim.keymap.set('v', '<leader>y', '"+y')
vim.keymap.set('v', '>', '>gv')
vim.keymap.set('v', '<', '<gv')

-- Selection
vim.keymap.set('n', 'vf', 'ggVG')

-- Find/replace
vim.keymap.set('n', '<leader>rl', '"ryiw:s/<c-r>r//g<left><left>')
vim.keymap.set('n', '<leader>rf', '"ryiw:%s/<c-r>r//g<left><left>')
vim.keymap.set('v', '<leader>rl', '"ry:s/<c-r>r//g<left><left>')
vim.keymap.set('v', '<leader>rf', '"ry:%s/<c-r>r//g<left><left>')

-- Quickfix
vim.keymap.set('n', '<leader>qo', '<cmd>copen<cr>')
vim.keymap.set('n', '<leader>qc', '<cmd>cclose<cr>')
vim.keymap.set('n', '<leader>qn', '<cmd>cnext<cr>')
vim.keymap.set('n', '<leader>qp', '<cmd>cprev<cr>')
vim.keymap.set('n', '<C-j>', '<cmd>cnext<cr>')
vim.keymap.set('n', '<C-k>', '<cmd>cprev<cr>')

-- Files
vim.keymap.set('n', '<leader>fp', '<cmd>FindProto<cr>')

-- Work
vim.keymap.set('n', '<leader>po', "<cmd>lua require('itmecho.utils.sparx').cd_to_project()<CR>")
vim.keymap.set('n', '<leader>pr', '<cmd>tcd ~/src/CloudExperiments<CR>')

-- Abbreviations
vim.cmd('cnoreabbrev N Neorg')
vim.cmd('cnoreabbrev NW Neorg workspace')
vim.cmd('cnoreabbrev NI Neorg index')
vim.cmd('cnoreabbrev W! w!')
vim.cmd('cnoreabbrev Q! q!')
vim.cmd('cnoreabbrev Qa! qa!')
vim.cmd('cnoreabbrev Qall! qall!')
vim.cmd('cnoreabbrev Wq wq')
vim.cmd('cnoreabbrev Wa wa')
vim.cmd('cnoreabbrev wQ wq')
vim.cmd('cnoreabbrev WQ wq')
vim.cmd('cnoreabbrev W w')
vim.cmd('cnoreabbrev Q q')
vim.cmd('cnoreabbrev Qa qa')
vim.cmd('cnoreabbrev Qall qall')
vim.cmd('cnoreabbrev Ack Ack!')
