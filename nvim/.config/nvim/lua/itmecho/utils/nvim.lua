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

function M.root_pattern(targets, exclude)
  return function(source)
    local root_dir = vim.fs.root(source, function(name)
      for _, target in ipairs(targets) do
        if target == name then
          return true
        end
      end
      return false
    end)
    print(root_dir)
    if root_dir == nil then
      return nil
    end

    exclude = exclude or {}

    for _, pattern in ipairs(exclude) do
      if root_dir:match(pattern) ~= nil then
        return nil
      end
    end

    return root_dir
  end
end

return M
