local M = {}

-- Track the current floating window and buffer managed by float_cmd
local current_float = {
  win = nil,
  buf = nil,
}

local function close_current_float()
  if current_float.win and vim.api.nvim_win_is_valid(current_float.win) then
    vim.api.nvim_win_close(current_float.win, true)
  end
  if current_float.buf and vim.api.nvim_buf_is_valid(current_float.buf) then
    vim.api.nvim_buf_delete(current_float.buf, { force = true })
  end
  current_float.win = nil
  current_float.buf = nil
end

M.float_cmd = function(cmd, opts)
  if cmd == nil or cmd == '' or type(cmd) ~= 'string' then
    error('cmd is a required string')
  end

  opts = vim.tbl_deep_extend('keep', opts or {}, {
    title = 'Output',
  })

  -- Close existing floating window if it exists
  close_current_float()

  -- Save current window to restore focus later
  local prev_win = vim.api.nvim_get_current_win()

  -- Create buffer for terminal
  local buf = vim.api.nvim_create_buf(false, true)
  vim.bo[buf].bufhidden = 'wipe'

  -- Calculate window position (top right) and size (1/3 of terminal)
  local ui = vim.api.nvim_list_uis()[1]
  local win_width = math.floor(ui.width / 3)
  local win_height = math.floor(ui.height / 3)
  local row = 1
  local col = ui.width - win_width - 2

  -- Create floating window
  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = win_width,
    height = win_height,
    row = row,
    col = col,
    style = 'minimal',
    border = 'rounded',
    title = ' ' .. opts.title .. ' ',
    title_pos = 'center',
  })

  -- Track this window and buffer as the current managed float
  current_float.win = win
  current_float.buf = buf

  -- Set up autocommands for resize on focus (separate group so it persists after command exits)
  local resize_augroup = vim.api.nvim_create_augroup('FloatCmdResize' .. buf, { clear = true })

  -- Expand window on focus, shrink on blur
  vim.api.nvim_create_autocmd('WinEnter', {
    group = resize_augroup,
    buffer = buf,
    callback = function()
      if not vim.api.nvim_win_is_valid(win) then
        return
      end
      -- Expand to 90% centered
      local current_ui = vim.api.nvim_list_uis()[1]
      local expanded_width = math.floor(current_ui.width * 0.9)
      local expanded_height = math.floor(current_ui.height * 0.9)
      local centered_row = math.floor((current_ui.height - expanded_height) / 2)
      local centered_col = math.floor((current_ui.width - expanded_width) / 2)
      vim.api.nvim_win_set_config(win, {
        relative = 'editor',
        width = expanded_width,
        height = expanded_height,
        row = centered_row,
        col = centered_col,
      })
    end,
  })

  vim.api.nvim_create_autocmd('WinLeave', {
    group = resize_augroup,
    buffer = buf,
    callback = function()
      if not vim.api.nvim_win_is_valid(win) then
        return
      end
      -- Return to original size (top right, 1/3 of terminal)
      local current_ui = vim.api.nvim_list_uis()[1]
      local small_width = math.floor(current_ui.width / 3)
      local small_height = math.floor(current_ui.height / 3)
      local small_row = 1
      local small_col = current_ui.width - small_width - 2
      vim.api.nvim_win_set_config(win, {
        relative = 'editor',
        width = small_width,
        height = small_height,
        row = small_row,
        col = small_col,
      })
    end,
  })

  -- Set up autocommand for scrolling (separate group, cleaned up on exit)
  local scroll_augroup = vim.api.nvim_create_augroup('FloatCmdScroll' .. buf, { clear = true })

  -- Auto-scroll to bottom when terminal output changes
  vim.api.nvim_create_autocmd('TermRequest', {
    group = scroll_augroup,
    buffer = buf,
    callback = function()
      if vim.api.nvim_win_is_valid(win) then
        local line_count = vim.api.nvim_buf_line_count(buf)
        vim.api.nvim_win_set_cursor(win, { line_count, 0 })
      end
    end,
  })

  -- Run command in terminal buffer (handles ANSI color codes)
  vim.fn.jobstart(cmd, {
    term = true,
    on_exit = function(_, exit_code)
      vim.schedule(function()
        -- Clean up scroll autocommand group (resize group persists)
        pcall(vim.api.nvim_del_augroup_by_id, scroll_augroup)

        if not vim.api.nvim_win_is_valid(win) then
          return
        end

        -- Scroll to bottom to show final output
        local line_count = vim.api.nvim_buf_line_count(buf)
        vim.api.nvim_win_set_cursor(win, { line_count, 0 })

        if exit_code == 0 then
          -- Success: close after 3 seconds
          vim.defer_fn(function()
            if current_float.win == win then
              close_current_float()
            elseif vim.api.nvim_win_is_valid(win) then
              vim.api.nvim_win_close(win, true)
            end
          end, 3000)
        else
          -- Failure: set border and title to red
          vim.api.nvim_set_option_value('winhl', 'FloatBorder:DiagnosticError,FloatTitle:@comment.error', { win = win })
        end
      end)
    end,
  })

  -- Start in normal mode for easier navigation
  vim.cmd('stopinsert')

  -- Return focus to previous window
  if vim.api.nvim_win_is_valid(prev_win) then
    vim.api.nvim_set_current_win(prev_win)
  end

  -- Allow closing with 'q'
  vim.keymap.set('n', 'q', function()
    if current_float.win == win then
      close_current_float()
    elseif vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
  end, { buffer = buf, nowait = true })
end

M.tmux_popup = function(cmd, opts)
  if cmd == nil or cmd == '' or type(cmd) ~= 'string' then
    error('cmd is a required string')
  end

  opts = vim.tbl_deep_extend('keep', opts or {}, {
    cwd = vim.uv.cwd(),
    width = '100%',
    height = '100%',
    position = {
      x = 'C',
      y = 'C',
    },
    auto_close = true,
  })


  -- stylua: ignore start
  local tmux_cmd = {
    'tmux',
    'display-popup',
    '-d', opts.cwd,
    '-w', opts.width,
    '-h', opts.height,
    '-x', opts.position.x,
    '-y', opts.position.y,
  }
  -- stylua: ignore end
  if opts.auto_close then
    table.insert(tmux_cmd, '-E')
  end
  table.insert(tmux_cmd, cmd)

  vim.fn.system(table.concat(tmux_cmd, ' '))
end

function M.job_lines(cmd, callback)
  return vim.fn.jobstart(cmd, {
    on_stdout = function(_, data)
      for _, line in ipairs(data) do
        if line ~= '' then
          callback(line)
        end
      end
    end,
  })
end

return M
