local group = vim.api.nvim_create_augroup("itmecho", {clear = true})

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "plugins.lua",
  command = "so % | PackerSync",
  group = group,
})
