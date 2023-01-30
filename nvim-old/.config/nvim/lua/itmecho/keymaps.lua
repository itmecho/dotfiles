vim.keymap.set('i', '<c-j>', function()
  require('luasnip').jump(1)
end)
vim.keymap.set('i', '<c-k>', function()
  require('luasnip').jump(-1)
end)
vim.keymap.set('i', '<c-h>', function()
  require('luasnip').change_choice(-1)
end)
vim.keymap.set('i', '<c-l>', function()
  require('luasnip').change_choice(1)
end)

local nnoremap = function(left, right, opts)
  vim.keymap.set('n', left, right, opts)
end
local tnoremap = function(left, right, opts)
  vim.keymap.set('t', left, right, opts)
end
local vnoremap = function(left, right, opts)
  vim.keymap.set('v', left, right, opts)
end

-- QoL
nnoremap('<esc>', '<cmd>noh<CR><esc>')
nnoremap('n', 'nzzzv')
nnoremap('<C-d>', '<C-d>zz')
nnoremap('<C-u>', '<C-u>zz')
nnoremap('<C-h>', '<cmd>tabprevious<cr>')
nnoremap('<C-l>', '<cmd>tabnext<cr>')
nnoremap('<C-/>', '<cmd>Telescope current_buffer_fuzzy_find<CR>')
nnoremap('<leader>y', '"+y')
nnoremap('<leader>y', '"+y')
vnoremap('>', '>gv')
vnoremap('<', '<gv')
vnoremap('<C-j>', ":m '>+1<cr>gv=gv")
vnoremap('<C-k>', ":m '<-2<cr>gv=gv")

-- Selection
nnoremap('vf', 'ggVG')

-- Find/replace
nnoremap('<leader>rl', '"ryiw:s/<c-r>r//g<left><left>')
nnoremap('<leader>rf', '"ryiw:%s/<c-r>r//g<left><left>')
vnoremap('<leader>rl', '"ry:s/<c-r>r//g<left><left>')
vnoremap('<leader>rf', '"ry:%s/<c-r>r//g<left><left>')

-- Quickfix
nnoremap('<leader>qo', '<cmd>copen<cr>')
nnoremap('<leader>qc', '<cmd>cclose<cr>')
nnoremap('<leader>qn', '<cmd>cnext<cr>')
nnoremap('<leader>qp', '<cmd>cprev<cr>')
nnoremap('<C-j>', '<cmd>cnext<cr>')
nnoremap('<C-k>', '<cmd>cprev<cr>')

-- Terminal
nnoremap('<leader>to', '<cmd>NeotermOpen<CR>')
nnoremap('<leader>to', '<cmd>NeotermOpen<CR>')
nnoremap('<leader>tc', '<cmd>NeotermClose<CR>')
nnoremap('<leader>tt', '<cmd>NeotermToggle<CR>')
nnoremap('<leader>tf', "<cmd>lua require'neoterm'.open({mode='fullscreen'})<CR>")
nnoremap('<leader>ts', ':NeotermRun ', { silent = false })
nnoremap('<leader>tr', '<cmd>NeotermRerun<CR>')
nnoremap('<leader>tx', '<cmd>NeotermExit<CR>')
tnoremap('<leader>tc', '<cmd>NeotermClose<CR>')
tnoremap('<leader>tt', '<cmd>NeotermToggle<CR>')
tnoremap('<leader>tn', '<C-\\><C-n>')
tnoremap('<leader>tx', '<cmd>NeotermExit<CR>')

-- Files
nnoremap('<leader>ff', '<cmd>Telescope find_files<cr>')
nnoremap('<leader>fb', '<cmd>Telescope file_browser<cr>')
nnoremap('<leader>fi', '<cmd>Telescope live_grep<cr>')
nnoremap('<leader>fc', '<cmd>Telescope find_files cwd=~/.config/nvim<cr>')
nnoremap('<leader>fp', '<cmd>FindProto<cr>')

-- Buffers
nnoremap('<leader>bl', '<cmd>Telescope buffers<cr>')
nnoremap('<leader>bc', "<cmd>lua require('itmecho.utils').delete_buffers({ keep_current = true })<cr>")
nnoremap('<leader>bx', "<cmd>lua require('itmecho.utils').delete_buffers()<cr>")
nnoremap('<leader>bn', '<cmd>bnext<cr>')
nnoremap('<leader>bp', '<cmd>bprevious<cr>')

-- Work
nnoremap('<leader>po', "<cmd>lua require('itmecho.utils.work').cd_to_project()<CR>")
nnoremap('<leader>pr', '<cmd>cd ~/src/CloudExperiments<CR>')
nnoremap('<leader>Sg', function()
  require('itmecho.utils').run_in_term(1, 'barx gazelle')
end)
nnoremap('<leader>Sp', function()
  require('itmecho.utils').run_in_term(1, 'barx proto')
end)
nnoremap('<leader>So', function()
  require('itmecho.utils.work').orca()
end)
nnoremap('<leader>ft', '<cmd>Telescope grep_string search=TODO(iain)<cr>')

-- Git
nnoremap('<leader>gs', '<cmd>lua require("neogit").open()<CR>')
nnoremap('<leader>gl', ':Neogit pull<CR>p')
nnoremap('<leader>gp', ':Neogit push<CR>p')
nnoremap('<leader>gP', ':Neogit push<CR>-up')
nnoremap('<leader>gb', '<cmd>Telescope git_branches<CR>')
nnoremap('<leader>gB', '<cmd>Neogit branch<CR>')
nnoremap('<leader>gx', function()
  require('gitsigns').blame_line()
end)
nnoremap('<leader>gX', function()
  require('gitsigns').blame_line({ full = true })
end)

-- Diagnostics
nnoremap('<leader>dn', '<cmd>lua vim.diagnostic.goto_next({wrap = true})<CR>')
nnoremap('<leader>dp', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
nnoremap('<leader>dl', '<cmd>TroubleToggle<CR>')
nnoremap('<leader>dd', '<cmd>TroubleToggle lsp_document_diagnostics<CR>')
nnoremap('<leader>dw', '<cmd>TroubleToggle lsp_workspace_diagnostics<CR>')

-- Harpoon
nnoremap('ghh', function()
  require('harpoon.ui').toggle_quick_menu()
end)
nnoremap('ghg', function()
  require('harpoon.mark').add_file()
  require('notify')('Added file')
end)
for _, mode in ipairs({ 'n', 't' }) do
  vim.keymap.set(mode, 'gha', "<cmd>lua require('harpoon.ui').nav_file(1)<cr>")
  vim.keymap.set(mode, 'ghs', "<cmd>lua require('harpoon.ui').nav_file(2)<cr>")
  vim.keymap.set(mode, 'ghd', "<cmd>lua require('harpoon.ui').nav_file(3)<cr>")
  vim.keymap.set(mode, 'ghf', "<cmd>lua require('harpoon.ui').nav_file(4)<cr>")
  vim.keymap.set(mode, 'gta', "<cmd>lua require('harpoon.term').gotoTerminal(1)<cr>")
  vim.keymap.set(mode, 'gts', "<cmd>lua require('harpoon.term').gotoTerminal(2)<cr>")
  vim.keymap.set(mode, 'gtd', "<cmd>lua require('harpoon.term').gotoTerminal(3)<cr>")
  vim.keymap.set(mode, 'gtf', "<cmd>lua require('harpoon.term').gotoTerminal(4)<cr>")
end

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