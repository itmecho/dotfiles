return {
  {
    'mason-org/mason-lspconfig.nvim',
    dependencies = {
      {
        'williamboman/mason.nvim',
        config = true,
      },
      { 'neovim/nvim-lspconfig' },
      { 'saghen/blink.cmp' },
    },
    opts = {
      ensure_installed = {
        'cssls',
        'cssmodules_ls',
        'css_variables',
        'eslint',
        'gopls',
        'golangci_lint_ls',
        'lua_ls',
        'stylelint_lsp',
        'tailwindcss',
        'ts_ls',
      },
    },
  },
}
