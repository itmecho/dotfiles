vim.bo.textwidth = 120
vim.wo.colorcolumn = "120"
vim.bo.expandtab = false
vim.bo.tabstop = 4
vim.bo.shiftwidth = 4
vim.bo.softtabstop = 4

vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

vim.cmd("command! -bang GoLines call v:lua.RunFormatCommand('golines -m 120 --base-formatter=gofmt')")

vim.keymap.set("n", "<leader><leader>t", require("itmecho.telescope").gotest)
