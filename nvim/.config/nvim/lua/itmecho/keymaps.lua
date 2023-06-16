local mapn = function(lhs, rhs, options)
  local opts = vim.tbl_extend('keep', options or {}, {
    silent = true,
    noremap = true,
  })

  vim.keymap.set('n', lhs, rhs, opts)
end

mapn('<leader>pb', '<cmd>Ex<cr>', { desc = "File explorer" })

-- Buffers
mapn('<leader>bd', function()
  local bufnr = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_delete(bufnr)
end, { desc = "Delete current buffer" })

mapn('<leader>bD', function()
  local buffers = vim.api.nvim_list_bufs()
  local current_buffer = vim.api.nvim_get_current_buf()
  for _, bufnr in ipairs(buffers) do
    if bufnr ~= current_buffer then
      vim.api.nvim_buf_delete(bufnr)
    end
  end
end, { desc = "Delete all buffers excluding the current buffer" })
