-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Defaults I actually want from LazyVim/lua/config/keymaps.lua
-- better up/down
local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

local util = require("lazyvim.util")

-- lazygit
map("n", "<leader>gg", '<cmd>Neogit<cr>', { desc = "Neogit (root dir)" })

-- floating terminal
map("n", "<leader>ft", function()
  util.float_term(nil, { cwd = util.get_root() })
end, { desc = "Terminal (root dir)" })
map("n", "<leader>fT", function()
  util.float_term()
end, { desc = "Terminal (cwd)" })
map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })

-- Custom Keymaps

map("n", "<leader>pr", function()
  vim.cmd("tcd " .. vim.env.CLOUDPATH)
end, { desc = "Change directory to the " })

map("n", "<leader>po", function()
  require("telescope.builtin").find_files({
    cwd = util.get_root(),
    find_command = { "fd", "--type", "d", "--max-depth", "3" },
    attach_mappings = function(_, map)
      map("i", "<cr>", function(prompt_bufnr)
        local project = require("telescope.actions.state").get_selected_entry()
        vim.cmd("tcd " .. project.path)
        require("telescope.actions").close(prompt_bufnr)
        vim.notify(
          "Changed to project " .. string.gsub(project.path, require("lazyvim.util").get_root() .. "/(.*)/", "%1")
        )
      end)

      return true
    end,
  })
end, { desc = "Change dir to sub-project" })

map('i', '<c-u>', '<c-r>=trim(system("uuidgen"))<cr>', { desc = "Generate and insert a uuid" })
