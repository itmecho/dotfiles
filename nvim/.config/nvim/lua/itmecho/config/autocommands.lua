local itmecho = vim.api.nvim_create_augroup("itmecho", {})
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "itmecho/plugins/*",
  command = "luafile <afile> | PackerCompile",
  group = itmecho,
})
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    require("nvim-web-devicons").setup()
  end,
  group = itmecho,
})
vim.api.nvim_create_autocmd("User", {
  pattern = "LspProgressUpdate",
  command = "redrawstatus!",
  group = itmecho,
})
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    local view = vim.fn.winsaveview()
    vim.cmd([[keeppatterns %s/\s\+$//e]])
    vim.fn.winrestview(view)
  end,
  group = itmecho,
})
