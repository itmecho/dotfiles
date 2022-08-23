vim.bo.textwidth = 100
vim.bo.expandtab = true
vim.bo.tabstop = 2
vim.bo.shiftwidth = 2
vim.bo.softtabstop = 2

vim.wo.colorcolumn = '101'

if vim.fn.isdirectory(vim.env.PWD .. '/node_modules') then
  vim.env.PATH = vim.env.PATH .. ':./node_modules/.bin'
end

function ESLint()
  vim.cmd([[cexpr system('pnpm lint -- -f unix --quiet')]])
end
