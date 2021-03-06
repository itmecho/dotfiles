vim.o.cmdheight = 2
vim.o.completeopt = "menuone,noinsert,noselect"
vim.o.errorformat = "%A%f:%l:%c:%m,%-G%.%#"
vim.o.hidden = true
vim.o.ignorecase = true
vim.o.incsearch = true
vim.o.list = true
vim.o.listchars = "eol:↵,tab:» "
vim.o.mouse = ""
vim.o.shiftwidth = 4
vim.o.shortmess = vim.o.shortmess .. "c"
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.softtabstop = 0
vim.o.spelllang = "en_gb"
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.statusline = "%!v:lua.StatusLine()"
vim.o.tabstop = 4
vim.o.termguicolors = true
vim.o.timeoutlen = 350
vim.o.updatetime = 300
vim.o.wildignore = ".git/*,.venv/*,*.pyc"

if vim.fn.executable("rg") then
    vim.o.grepprg = "rg --vimgrep --no-heading"
    vim.o.grepformat = "%f:%l:%c:%m,%f:%l:%m"
end

vim.bo.expandtab = false
vim.bo.swapfile = false
vim.bo.shiftwidth = 4
vim.bo.softtabstop = 0
vim.bo.tabstop = 4

vim.wo.cursorline = true
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
vim.wo.foldlevel = 200
vim.wo.foldmethod = "expr"
vim.wo.list = true
vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.signcolumn = "yes"
