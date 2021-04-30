local keymap = require("itmecho.utils").keymap

keymap("i", "<Tab>", 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true})
keymap("i", "<S-Tab>", 'pumvisible() ? "\\<C-p>" : "\\<S-Tab>"', {expr = true})
keymap("i", "<C-Space>", "compe#complete()", {expr = true})
keymap("i", "<CR>", "compe#confirm('<CR>')", {expr = true})

keymap("n", "<leader>ts", ":NeotermRun ", {silent = false})
keymap("n", "<leader>T", "<cmd>NeotermToggle<CR>")
keymap("n", "<leader>tt", "<cmd>NeotermInteractive<CR>")
keymap("n", "<leader>tr", "<cmd>NeotermRerun<CR>")
keymap("n", "<leader>tx", "<cmd>NeotermExit<CR>")
keymap("t", "<leader>T", "<cmd>NeotermToggle<CR>")
keymap("t", "<leader>tn", "<C-\\><C-n>")
keymap("t", "<leader>tt", "<cmd>NeotermInteractive<CR>")
keymap("t", "<leader>tx", "<cmd>NeotermExit<CR>")

keymap("v", ">", ">gv")
keymap("v", "<", "<gv")

require("which-key").register(
    {
        ["<esc>"] = {"<cmd>noh<CR><esc>", "Escape & Clear Highlights"},
        ["n"] = {"nzzzv", "Next Search Item Centered"},
        ["K"] = {"<cmd>Lspsaga hover_doc<CR>", "Hover Docs"},
        ["<C-p>"] = {"<cmd>Telescope find_files<cr>", "Find Files"},
        ["<C-j>"] = {"<cmd>cnext<cr>", "Next Quickfix Item"},
        ["<C-k>"] = {"<cmd>cprev<cr>", "Previous Quickfix Item"},
        ["<C-]>"] = {"<cmd>lua vim.lsp.buf.definition()<CR>", "Go To Definition"},
        ["<leader>"] = {
            f = {
                name = "+find",
                f = {"<cmd>Telescope find_files<cr>", "Find Files"},
                b = {"<cmd>lua require('itmecho.telescope').file_browser()<CR>", "Find Files"},
                s = {"<cmd>lua require('itmecho.telescope').search_string()<CR>", "Search for string"},
                i = {"<cmd>Telescope live_grep<cr>", "Search Interactive"},
                c = {"<cmd>Telescope find_files cwd=~/.config/nvim<CR>", "Find Neovim Config"}
            },
            b = {
                name = "+buffer",
                n = {"<cmd>bnext<cr>", "Next Buffer"},
                p = {"<cmd>bprevious<cr>", "Previous Buffer"},
                l = {"<cmd>Telescope buffers<cr>", "List Buffers"},
                c = {"<cmd>bufdo bd<cr>", "Close Buffer"}
            },
            p = {
                name = "+project",
                o = {"<cmd>lua require('itmecho.telescope').cd_to_project()<CR>", "Open CloudExperiments Project"},
                r = {"<cmd>cd ~/src/CloudExperiments<CR>", "CloudExperiments Root"}
            },
            q = {
                name = "+quickfix",
                o = {"<cmd>copen<cr>", "Open Quickfix"},
                c = {"<cmd>cclose<cr>", "Close Quickfix"},
                n = {"<cmd>cnext<cr>", "Next Quickfix Item"},
                p = {"<cmd>cprev<cr>", "Previous Quickfix Item"}
                -- o = { "", "" },
            },
            g = {
                name = "+git",
                s = {"<cmd>Gstatus<CR>", "Git Status"},
                l = {"<cmd>G pull<CR>", "Git Pull"},
                p = {"<cmd>G push<CR>", "Git Push"},
                b = {"<cmd>lua require('itmecho.telescope').git_branches()<CR>", "Git Branches"}
            },
            v = {
                name = "+lsp",
                d = {"<cmd>Lspsaga preview_definition<CR>", "Preview Definition"},
                s = {"<cmd>Lspsaga signature_help<CR>", "Signature Help"},
                r = {"yiw:Lspsaga rename<CR><c-r>0", "Rename"},
                R = {"<cmd>lua vim.lsp.buf.references()<CR>", "Find References"},
                a = {"<cmd>Lspsaga code_action<CR>", "Code Actions"}
            },
            d = {
                name = "diagnostics",
                n = {"<cmd>Lspsaga diagnostic_jump_next<CR>", "Next Diagnostic"},
                p = {"<cmd>Lspsaga diagnostic_jump_prev<CR>", "Previous Diagnostic"},
                l = {"<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", "List Diagnostics"},
                d = {"<cmd>LspTroubleDocumentToggle<CR>", "Document Diagnostics"},
                w = {"<cmd>LspTroubleWorkspaceToggle<CR>", "Workspace Diagnostics"}
            },
            o = {"<cmd>lua require('itmecho.telescope').orca()<CR>", "Orca"},
            S = {"<cmd>set spell!<CR>", "Toggle Spell"}
        }
    }
)

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
