vim.cmd("filetype plugin indent on")
vim.cmd("syntax on")

vim.g.completion_matching_strategy_list = { "exact", "substring", "fuzzy" }

vim.g.diagnostic_enable_underline = 1
vim.g.diagnostic_enable_virtual_text = 1
vim.g.diagnostic_show_sign = 1

vim.g.dracula_italic = 0

vim.g.neoformat_try_node_exe = true

vim.g.netrw_banner = 0

-- vim.g.nord_italic = false

vim.g["prettier#quickfix_enabled"] = false

vim.cmd("colorscheme " .. vim.env.THEME:lower())
