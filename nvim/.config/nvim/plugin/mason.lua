vim.pack.add({
  { src = 'https://github.com/neovim/nvim-lspconfig' },
  { src = 'https://github.com/mason-org/mason.nvim' },
  { src = 'https://github.com/mason-org/mason-lspconfig.nvim' },
})

require('mason').setup()
require('mason-lspconfig').setup()

local ensure_installed = {
  'astro-language-server',
  'clang-format',
  'css-lsp',
  'css-variables-language-server',
  'cssmodules-language-server',
  'delve',
  'eslint-lsp',
  'eslint_d',
  'goimports',
  'goimports-reviser',
  'golangci-lint',
  'golangci-lint-langserver',
  'golines',
  'gopls',
  'lua-language-server',
  'luacheck',
  'prettier',
  'protols',
  'sql-formatter',
  'stylelint-language-server',
  'stylua',
  'tailwindcss-language-server',
  'typescript-language-server',
}
local installed = require('mason-registry').get_installed_package_names()
local missing = vim
  .iter(ensure_installed)
  :filter(function(parser)
    return not vim.tbl_contains(installed, parser)
  end)
  :totable()

if #missing > 0 then
  vim.cmd('MasonInstall ' .. table.concat(missing, ' '))
end
