local M = {}

-- Closes all buffers except for the current buffer.
function M.clean_buffers()
  local buffers = vim.api.nvim_list_bufs()
  local current_buffer = vim.api.nvim_get_current_buf()
  for _, bufnr in ipairs(buffers) do
    if bufnr ~= current_buffer then
      vim.api.nvim_buf_delete(bufnr, {})
    end
  end
end

-- Wraps a function call in an anonymous function.
function M.defer_call(fn, ...)
  local args = { ... }
  return function()
    fn(unpack(args))
  end
end

return M
