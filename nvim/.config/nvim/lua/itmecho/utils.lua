local M = {}

M.delete_buffers = function(opts)
  opts = vim.tbl_extend("keep", opts or {}, {
    keep_current = false,
  })

  local bufs = vim.api.nvim_list_bufs()
  local current_buf = vim.api.nvim_get_current_buf()
  local count = 0
  for _, buf in pairs(bufs) do
    -- Skip current buffer if keep_current is set
    if not (buf == current_buf and opts.keep_current) then
      -- Only close listed buffers
      local listed = vim.api.nvim_buf_get_option(buf, "buflisted")

      if listed then
        vim.api.nvim_buf_delete(buf, {})
        count = count + 1
      end
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
  vim.cmd(string.format("edit %s/Documents/todo.norg", home))
  vim.keymap.set("n", "q", ":q<cr>", { buffer = true })
end

function M.install_lsp_servers()
  install_lsp_servers(false)
end

function M.update_lsp_servers()
  install_lsp_servers(true)
end

return M
