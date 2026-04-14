vim.pack.add({ 'https://github.com/nvim-treesitter/nvim-treesitter' })

local ensure_installed = { 'go', 'lua', 'typescript', 'tsx' }
local installed = require('nvim-treesitter.config').get_installed()
local missing = vim
  .iter(ensure_installed)
  :filter(function(parser)
    return not vim.tbl_contains(installed, parser)
  end)
  :totable()

require('nvim-treesitter').install(missing)
vim.api.nvim_create_autocmd('FileType', {
  callback = function()
    -- Enable treesitter highlighting and disable regex syntax
    pcall(vim.treesitter.start)
    -- Enable treesitter-based indentation
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})
