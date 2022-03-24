local M = {}

function M.open_float(opts)
  local ui = vim.api.nvim_list_uis()[1]

  opts = vim.tbl_deep_extend("keep", opts or {}, {
    bufh = nil,
    delete_buf_on_close = true,
    write_on_close = false,
    scale = 1,
  })

  -- Force a max scale of 1 and a minimum of 0.1
  if opts.scale > 1 then
    opts.scale = 1
  elseif opts.scale < 0 then
    opts.scale = 0.1
  end

  -- Calculate width and height
  local width = math.floor(ui.width * opts.scale)
  local height = math.floor((ui.height * opts.scale) - vim.o.cmdheight - 3)

  local winopts = {
    relative = "editor",
    width = width,
    height = height,
    row = 0,
    col = 1,
    style = "minimal",
    border = "single",
  }

  -- If scale isn't 100%, calculate the row and column offsets
  if opts.scale < 1 then
    winopts.row = math.floor((ui.height - height - vim.o.cmdheight - 3) / 2)
    winopts.col = math.floor((ui.width - width) / 2)
  end

  local bufh = opts.bufh or vim.api.nvim_create_buf(true, false)

  local winh = vim.api.nvim_open_win(bufh, true, winopts)

  local group_name = "itmecho_ui_" .. os.date("%s")
  local augroup = vim.api.nvim_create_augroup(group_name, {})
  vim.api.nvim_create_autocmd("WinClosed", {
    callback = function()
      if opts.write_on_close then
        vim.cmd("write")
      end
      if opts.delete_buf_on_close then
        vim.api.nvim_buf_delete(bufh, {})
      end
      vim.api.nvim_del_augroup_by_name(group_name)
    end,
    pattern = tostring(winh),
    group = augroup,
  })
end

return M
