return {
  'jose-elias-alvarez/null-ls.nvim',
  opts = function()
    local nls = require('null-ls')
    return {
      sources = {
        -- Diagnostics
        nls.builtins.code_actions.eslint_d,

        -- Diagnostics
        nls.builtins.diagnostics.eslint_d,
        nls.builtins.diagnostics.golangci_lint,

        -- Formatting
        nls.builtins.formatting.golines.with({
          extra_args = { '--max-len', '120', '--base-formatter', 'goimports' },
        }),
        nls.builtins.formatting.eslint_d,
        nls.builtins.formatting.prettier,
      },
    }
  end,
}
