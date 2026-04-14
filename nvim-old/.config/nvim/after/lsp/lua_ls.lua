return {
  settings = {
    Lua = {
      hint = {
        enable = true,
        arrayIndex = 'Auto',
        await = true,
        paramName = true,
        paramType = true,
        semicolon = true,
        setType = true,
      },
      workspace = {
        checkThirdParty = false,
        telemetry = { enable = false },
        library = vim.api.nvim_get_runtime_file('', true),
      },
    },
  },
}
