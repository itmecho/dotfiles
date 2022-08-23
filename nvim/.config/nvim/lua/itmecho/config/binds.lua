vim.keymap.set("i", "<c-j>", function()
	require("luasnip").jump(1)
end)
vim.keymap.set("i", "<c-k>", function()
	require("luasnip").jump(-1)
end)
vim.keymap.set("i", "<c-h>", function()
	require("luasnip").change_choice(-1)
end)
vim.keymap.set("i", "<c-l>", function()
	require("luasnip").change_choice(1)
end)

-- Terminal
vim.keymap.set("n", "<leader>to", "<cmd>NeotermOpen<CR>")
vim.keymap.set("n", "<leader>tc", "<cmd>NeotermClose<CR>")
vim.keymap.set("n", "<leader>tt", "<cmd>NeotermToggle<CR>")
vim.keymap.set("n", "<leader>tf", "<cmd>lua require'neoterm'.open({mode='fullscreen'})<CR>")
vim.keymap.set("n", "<leader>ts", ":NeotermRun ", { silent = false })
vim.keymap.set("n", "<leader>tr", "<cmd>NeotermRerun<CR>")
vim.keymap.set("n", "<leader>tx", "<cmd>NeotermExit<CR>")
vim.keymap.set("t", "<leader>tc", "<cmd>NeotermClose<CR>")
vim.keymap.set("t", "<leader>tt", "<cmd>NeotermToggle<CR>")
vim.keymap.set("t", "<leader>tn", "<C-\\><C-n>")
vim.keymap.set("t", "<leader>tx", "<cmd>NeotermExit<CR>")

vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")

-- vim.keymap.set("n", "<leader>J", "<cmd>lua require('itmecho.utils').journal()<CR>")
-- vim.keymap.set("n", "<leader>T", "<cmd>lua require('itmecho.utils').todo()<CR>")

vim.keymap.set("n", "<esc>", "<cmd>noh<CR><esc>")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "<C-p>", "<cmd>Telescope find_files<cr>")
vim.keymap.set("n", "<C-h>", "<cmd>tabprevious<cr>")
vim.keymap.set("n", "<C-l>", "<cmd>tabnext<cr>")
vim.keymap.set("n", "<C-j>", "<cmd>cnext<cr>")
vim.keymap.set("n", "<C-k>", "<cmd>cprev<cr>")
vim.keymap.set("n", "<C-]>", "<cmd>lua vim.lsp.buf.definition()<CR>")
vim.keymap.set("n", "<C-/>", "<cmd>Telescope current_buffer_fuzzy_find<CR>")

vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope file_browser<cr>")
vim.keymap.set("n", "<leader>fi", "<cmd>Telescope live_grep<cr>")
vim.keymap.set("n", "<leader>fc", "<cmd>Telescope find_files cwd=~/.config/nvim<cr>")
vim.keymap.set("n", "<leader>ft", "<cmd>NvimTreeToggle<cr>")

vim.keymap.set("n", "<leader>bn", "<cmd>bnext<cr>")
vim.keymap.set("n", "<leader>bp", "<cmd>bprevious<cr>")
vim.keymap.set("n", "<leader>bl", "<cmd>Telescope buffers<cr>")
vim.keymap.set("n", "<leader>bc", "<cmd>lua require('itmecho.utils').delete_buffers({ keep_current = true })<cr>")
vim.keymap.set("n", "<leader>bx", "<cmd>lua require('itmecho.utils').delete_buffers()<cr>")

vim.keymap.set("n", "<leader>po", "<cmd>lua require('itmecho.telescope').cd_to_project()<CR>")
vim.keymap.set("n", "<leader>pr", "<cmd>cd ~/src/CloudExperiments<CR>")

vim.keymap.set("n", "<leader>qo", "<cmd>copen<cr>")
vim.keymap.set("n", "<leader>qc", "<cmd>cclose<cr>")
vim.keymap.set("n", "<leader>qn", "<cmd>cnext<cr>")
vim.keymap.set("n", "<leader>qp", "<cmd>cprev<cr>")

vim.keymap.set("n", "<leader>gs", "<cmd>Neogit<CR>")
vim.keymap.set("n", "<leader>gl", ":Neogit pull<CR>p")
vim.keymap.set("n", "<leader>gp", ":Neogit push<CR>p")
vim.keymap.set("n", "<leader>gP", ":Neogit push<CR>-up")
vim.keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<CR>")
vim.keymap.set("n", "<leader>gB", "<cmd>Neogit branch<CR>")
vim.keymap.set("n", "<leader>gx", require("gitsigns").blame_line)

vim.keymap.set("n", "<leader>dn", "<cmd>lua vim.diagnostic.goto_next({wrap = true})<CR>")
vim.keymap.set("n", "<leader>dp", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
vim.keymap.set("n", "<leader>dl", "<cmd>TroubleToggle<CR>")
vim.keymap.set("n", "<leader>dd", "<cmd>TroubleToggle lsp_document_diagnostics<CR>")
vim.keymap.set("n", "<leader>dw", "<cmd>TroubleToggle lsp_workspace_diagnostics<CR>")

vim.keymap.set("n", "<leader>Sg", function()
	require("itmecho.utils").run_in_term(1, "barx gazelle")
end)
vim.keymap.set("n", "<leader>Sp", function()
	require("itmecho.utils").run_in_term(1, "barx proto")
end)
vim.keymap.set("n", "<leader>So", require("itmecho.telescope").orca)

vim.keymap.set("n", "<leader>hh", require("harpoon.ui").toggle_quick_menu)
vim.keymap.set("n", "<leader>ha", "<cmd>lua require('harpoon.mark').add_file();require('notify')('Added file')<cr>")
vim.keymap.set("n", "<leader>h1", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>")
vim.keymap.set("n", "<leader>h2", "<cmd>lua require('harpoon.ui').nav_file(2)<cr>")
vim.keymap.set("n", "<leader>h3", "<cmd>lua require('harpoon.ui').nav_file(3)<cr>")
vim.keymap.set("n", "<leader>h4", "<cmd>lua require('harpoon.ui').nav_file(4)<cr>")
vim.keymap.set("n", "<leader>H1", "<cmd>lua require('harpoon.term').gotoTerminal(1)<cr>")
vim.keymap.set("n", "<leader>H2", "<cmd>lua require('harpoon.term').gotoTerminal(2)<cr>")
vim.keymap.set("n", "<leader>H3", "<cmd>lua require('harpoon.term').gotoTerminal(3)<cr>")
vim.keymap.set("n", "<leader>H4", "<cmd>lua require('harpoon.term').gotoTerminal(4)<cr>")

vim.keymap.set("n", "ghh", require("harpoon.ui").toggle_quick_menu)
vim.keymap.set("n", "ghg", "<cmd>lua require('harpoon.mark').add_file();require('notify')('Added file')<cr>")
for _, mode in ipairs({ "n", "t" }) do
	vim.keymap.set(mode, "gha", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>")
	vim.keymap.set(mode, "ghs", "<cmd>lua require('harpoon.ui').nav_file(2)<cr>")
	vim.keymap.set(mode, "ghd", "<cmd>lua require('harpoon.ui').nav_file(3)<cr>")
	vim.keymap.set(mode, "ghf", "<cmd>lua require('harpoon.ui').nav_file(4)<cr>")
	vim.keymap.set(mode, "gta", "<cmd>lua require('harpoon.term').gotoTerminal(1)<cr>")
	vim.keymap.set(mode, "gts", "<cmd>lua require('harpoon.term').gotoTerminal(2)<cr>")
	vim.keymap.set(mode, "gtd", "<cmd>lua require('harpoon.term').gotoTerminal(3)<cr>")
	vim.keymap.set(mode, "gtf", "<cmd>lua require('harpoon.term').gotoTerminal(4)<cr>")
end

-- DAP
local dap = require("dap")
vim.keymap.set("n", "<F1>", dap.continue)
vim.keymap.set("n", "<F2>", dap.step_over)
vim.keymap.set("n", "<F3>", dap.step_into)
vim.keymap.set("n", "<F4>", dap.step_out)
vim.keymap.set("n", "<leader>B", dap.toggle_breakpoint)

-- Abbreviations
vim.cmd("cnoreabbrev W! w!")
vim.cmd("cnoreabbrev Q! q!")
vim.cmd("cnoreabbrev Qa! qa!")
vim.cmd("cnoreabbrev Qall! qall!")
vim.cmd("cnoreabbrev Wq wq")
vim.cmd("cnoreabbrev Wa wa")
vim.cmd("cnoreabbrev wQ wq")
vim.cmd("cnoreabbrev WQ wq")
vim.cmd("cnoreabbrev W w")
vim.cmd("cnoreabbrev Q q")
vim.cmd("cnoreabbrev Qa qa")
vim.cmd("cnoreabbrev Qall qall")
vim.cmd("cnoreabbrev Ack Ack!")
