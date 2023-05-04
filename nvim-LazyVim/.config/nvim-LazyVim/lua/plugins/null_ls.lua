return {
  "jose-elias-alvarez/null-ls.nvim",
  opts = function()
    local nls = require("null-ls")
    return {
      sources = {
        -- Diagnostics
        nls.builtins.diagnostics.eslint_d,

        -- Formatting
        nls.builtins.formatting.golines.with({
          extra_args = { "--max-len", "120", "--base-formatter", "goimports" },
        }),
        nls.builtins.formatting.eslint_d,
      },
    }
  end,
}
