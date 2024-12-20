local mapn = function(lhs, rhs, options)
  local opts = vim.tbl_extend('keep', options or {}, {
    silent = true,
    noremap = true,
  })

  vim.keymap.set('n', lhs, rhs, opts)
end

mapn('<esc>', '<esc>:noh<cr>')
vim.keymap.set('v', '>', '>gv')
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('n', 'n', 'nzz')
vim.keymap.set('n', 'N', 'Nzz')
vim.keymap.set('n', ']q', '<cmd>cnext<cr>zz')
vim.keymap.set('n', '[q', '<cmd>cprev<cr>zz')
vim.keymap.set('n', ']t', vim.cmd.tabnext)
vim.keymap.set('n', '[t', vim.cmd.tabprev)
vim.keymap.set('n', ']d', function()
  vim.diagnostic.goto_next({ wrap = true, float = true })
end)
vim.keymap.set('n', '[d', function()
  vim.diagnostic.goto_prev({ wrap = true, float = true })
end)

vim.keymap.set('v', '<leader>y', '"+y')

vim.keymap.set('i', '<c-u>', "<c-r>=tolower(trim(system('uuidgen')))<cr>")

-- Buffers
mapn('<leader>bd', function()
  local bufnr = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_delete(bufnr)
end, { desc = 'Delete current buffer' })

mapn('<leader>bD', function()
  local buffers = vim.api.nvim_list_bufs()
  local current_buffer = vim.api.nvim_get_current_buf()
  for _, bufnr in ipairs(buffers) do
    if bufnr ~= current_buffer then
      vim.api.nvim_buf_delete(bufnr)
    end
  end
end, { desc = 'Delete all buffers excluding the current buffer' })

vim.keymap.set('v', '<leader>cf', "<cmd>Format<cr>")

vim.keymap.set('v', '<leader>64', "c<c-r>=system('echo \"<c-r>\"\" | base64 -d | tr -d \"\\n\"')<cr><esc>")
vim.keymap.set('v', '<leader><leader>64', "c<c-r>=system('echo \"<c-r>\"\" | base64 | tr -d \"\\n\"')<cr><esc>")
