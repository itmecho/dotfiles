local lsp_status = require("lsp-status")
lsp_status.register_progress()
lsp_status.config({
  indicator_errors = "%#DiagnosticSignError#%#DiagnoticSignOther#",
  indicator_warnings = "%#DiagnosticSignWarn#%#DiagnosticSignOther#",
  indicator_info = "%#DiagnosticSignInfo#%#DiagnosticSignOther#",
  indicator_hint = "%#DiagnosticSignHint#ﬤ%#DiagnosticSignOther#",
  indicator_ok = "",
  status_symbol = "",
})

require("lualine").setup({
  options = {
    globalstatus = true,
    icons_enabled = true,
    theme = vim.env.THEME:lower(),
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = {
      { "filetype", colored = 1 },
    },
    lualine_c = {
      { "filename", path = 1 },
    },
    lualine_x = { "require'lsp-status'.status()" },
    lualine_y = {},
    lualine_z = { "branch" },
  },
})
