local M = {}

M.tmux_popup = function(cmd, opts)
  if cmd == nil or cmd == '' or type(cmd) ~= 'string' then
    error('cmd is a required string')
  end

  opts = vim.tbl_deep_extend('keep', opts or {}, {
    width = '90%',
    height = '90%',
    position = {
      x = 'C',
      y = 'C',
    },
    auto_close = true,
  })

  local tmux_cmd =
    { 'tmux', 'display-popup', '-w', opts.width, '-h', opts.height, '-x', opts.position.x, '-y', opts.position.y }
  if opts.auto_close then
    table.insert(tmux_cmd, '-E')
  end
  table.insert(tmux_cmd, cmd)

  vim.fn.system(table.concat(tmux_cmd, ' '))
end

return M
