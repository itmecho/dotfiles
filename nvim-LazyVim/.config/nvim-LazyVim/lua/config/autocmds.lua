-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
local itmecho = vim.api.nvim_create_augroup("itmecho", {})
vim.api.nvim_create_autocmd('FileType',
  {
    pattern = 'NeogitCommitMessage',
    callback = function()
      vim.cmd.startinsert()
    end,
    group = itmecho
  })
