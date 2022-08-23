vim.api.nvim_set_var('neoformat_enabled_typescript', { 'prettier' })

-- bootstrap packer
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({ 'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path })
  require('itmecho.plugins.init')
  vim.cmd('autocmd User PackerComplete ++once lua require("itmecho.init")')
  require('packer').sync()
else
  require('itmecho.plugins.init')
  require('itmecho.init')
end
