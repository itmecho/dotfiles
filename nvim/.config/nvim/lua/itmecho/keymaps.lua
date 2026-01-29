local tmux_popup = require('itmecho.utils.cmd').tmux_popup
local defer_call = require('itmecho.utils.nvim').defer_call

local nopts = { silent = true, noremap = true }

vim.keymap.set('n', '<esc>', '<esc>:noh<cr>', nopts)
-- Center search results
for _, lhs in ipairs({ 'n', 'N', '}', '{', '<c-d>', '<c-u>' }) do
  vim.keymap.set('n', lhs, lhs .. 'zz', nopts)
end
vim.keymap.set('n', ']q', '<cmd>cnext<cr>zz', nopts)
vim.keymap.set('n', '[q', '<cmd>cprev<cr>zz', nopts)
vim.keymap.set('n', ']d', defer_call(vim.diagnostic.goto_next, { wrap = true, float = true }))
vim.keymap.set('n', '[d', defer_call(vim.diagnostic.goto_prev, { wrap = true, float = true }))
vim.keymap.set('n', '<leader>bd', defer_call(vim.api.nvim_buf_delete, 0), nopts)
vim.keymap.set('n', '<leader>bD', require('itmecho.utils.nvim').clean_buffers, nopts)
vim.keymap.set('n', '<leader>wf', '<cmd>tab split<CR>', nopts)

vim.keymap.set('n', '<leader>Sg', function()
  require('itmecho.utils.cmd').float_cmd('spxdev gen gazelle', { title = 'Gazelle' })
end)
vim.keymap.set('n', '<leader>Sp', function()
  require('itmecho.utils.cmd').float_cmd('spxdev gen proto', { title = 'Proto' })
end)
vim.keymap.set('n', '<leader>pr', defer_call(require('itmecho.utils.git').create_pr, { open_in_octo = true }))

vim.keymap.set('n', '<leader>g', function()
  require('itmecho.utils.cmd').tmux_popup('lazygit')
end)

vim.keymap.set('v', '<leader>y', '"+y')
vim.keymap.set('v', '>', '>gv')
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '<leader>64', 'c<c-r>=system(\'echo "<c-r>"" | base64 -d | tr -d "\\n"\')<cr><esc>')
vim.keymap.set('v', '<leader><leader>64', 'c<c-r>=system(\'echo "<c-r>"" | base64 | tr -d "\\n"\')<cr><esc>')

vim.keymap.set('i', '<c-u>', "<c-r>=tolower(trim(system('uuidgen')))<cr>")
vim.keymap.set('i', '<c-l>', "<c-r>=trim(system('ulid'))<cr>")
vim.keymap.set('t', '<esc>', '<c-\\><c-n>')

vim.keymap.set('n', '<leader>wc', function()
  vim.cmd(string.format('vertical resize %d', vim.o.colorcolumn + 6))
end, { desc = 'Set current window width to color column' })
