local M = {}

-- TODO Move this to a more appropriate file and make it global
-- so we can call v:lua.RunFormatCommand()
M.run_format_command = function(cmd)
  local view = vim.fn.winsaveview()
  vim.cmd('silent execute "%!' .. cmd .. '"')
  if vim.v.shell_error ~= 0 then
    vim.cmd("undo")
  end
  vim.fn.winrestview(view)
end

M.set_autocommands = function(group_name, autocommands)
  vim.cmd("augroup " .. group_name)
  vim.cmd("autocmd!")
  for _, a in ipairs(autocommands) do
    vim.cmd("autocmd " .. table.concat(a, " "))
  end
  vim.cmd("augroup END")
end

M.keymap = function(mode, lhs, rhs, extra_opts)
  extra_opts = extra_opts or {}
  local opts = {
    noremap = true,
    silent = true,
  }
  for k, v in pairs(extra_opts) do
    opts[k] = v
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
end

M.close_all_other_buffers = function()
  local bufs = vim.api.nvim_list_bufs()
  local current_buf = vim.api.nvim_get_current_buf()
  local count = 0
  for _, buf in pairs(bufs) do
    -- Only close listed buffers
    local listed = vim.api.nvim_buf_get_option(buf, "buflisted")

    -- Don't close current buffer
    if buf ~= current_buf and listed then
      vim.api.nvim_buf_delete(buf, {})
      count = count + 1
    end
  end

  print("closed " .. count .. " buffers")
end

local function install_lsp_servers(update)
  local installer = require("nvim-lsp-installer")
  local servers = require("nvim-lsp-installer.servers")

  local wanted = {
    "eslint",
    "gopls",
    "rust_analyzer",
    "sumneko_lua",
    "svelte",
    "tailwindcss",
    "tsserver",
  }

  installer.display()

  for _, server in pairs(wanted) do
    local ok, srv = servers.get_server(server)
    if ok then
      if srv:is_installed() ~= true or update then
        srv:install()
      end
    else
      print(server .. " is not a valid lsp server")
    end
  end
end

function M.file_exists(path)
  local f = io.open(path, "r")
  if f ~= nil then
    io.close(f)
    return true
  else
    return false
  end
end

function M.journal()
  require("itmecho.ui").open_float({ write_on_close = true })
  local date = os.date("%Y-%m-%d")
  local home = os.getenv("HOME")
  local filepath = string.format("%s/Documents/journal/%s.norg", home, date)
  vim.cmd("edit " .. filepath)

  if not M.file_exists(filepath) then
    local day = os.date("%-d")
    local day_suffix = "th"
    local day_last_digit = string.sub(day, -1)
    if day_last_digit == "1" then
      day_suffix = "st"
    elseif day_last_digit == "2" then
      day_suffix = "nd"
    elseif day_last_digit == "3" then
      day_suffix = "rd"
    end

    local pretty_date = os.date("%A %-d" .. day_suffix .. " %B, %Y")
    vim.api.nvim_buf_set_lines(0, 0, 1, true, { "* " .. pretty_date, "" })
  end
end

function M.todo()
  require("itmecho.ui").open_float({ write_on_close = true })
  local home = os.getenv("HOME")
  vim.cmd(string.format("edit %s/.todo.norg", home))
end

function M.install_lsp_servers()
  install_lsp_servers(false)
end

function M.update_lsp_servers()
  install_lsp_servers(true)
end

return M
