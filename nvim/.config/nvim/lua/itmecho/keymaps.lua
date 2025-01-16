local tmux_popup = require('itmecho.utils.cmd').tmux_popup
local defer_call = require('itmecho.utils.nvim').defer_call

local nopts = { silent = true, noremap = true }

vim.keymap.set('n', '<esc>', '<esc>:noh<cr>', nopts)
-- Center search results
vim.keymap.set('n', 'n', 'nzz', nopts)
vim.keymap.set('n', 'N', 'Nzz', nopts)
vim.keymap.set('n', ']q', '<cmd>cnext<cr>zz', nopts)
vim.keymap.set('n', '[q', '<cmd>cprev<cr>zz', nopts)
vim.keymap.set('n', ']d', defer_call(vim.diagnostic.goto_next, { wrap = true, float = true }))
vim.keymap.set('n', '[d', defer_call(vim.diagnostic.goto_prev, { wrap = true, float = true }))
vim.keymap.set('n', '<leader>bd', defer_call(vim.api.nvim_buf_delete, 0), nopts)
vim.keymap.set('n', '<leader>bD', require('itmecho.utils.nvim').clean_buffers, nopts)

vim.keymap.set('n', '<leader>Sg', defer_call(tmux_popup, 'spxdev gen gazelle'))
vim.keymap.set('n', '<leader>Sp', defer_call(tmux_popup, 'spxdev gen proto'))
vim.keymap.set('n', '<leader>g', defer_call(tmux_popup, 'lazygit'))

vim.keymap.set('v', '<leader>y', '"+y')
vim.keymap.set('v', '>', '>gv')
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '<leader>64', 'c<c-r>=system(\'echo "<c-r>"" | base64 -d | tr -d "\\n"\')<cr><esc>')
vim.keymap.set('v', '<leader><leader>64', 'c<c-r>=system(\'echo "<c-r>"" | base64 | tr -d "\\n"\')<cr><esc>')

vim.keymap.set('i', '<c-u>', "<c-r>=tolower(trim(system('uuidgen')))<cr>")
vim.keymap.set('i', '<c-l>', "<c-r>=trim(system('ulid'))<cr>")
vim.keymap.set('t', '<esc>', '<c-\\><c-n>')
