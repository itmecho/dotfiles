vim.bo.textwidth = 100
vim.bo.expandtab = true
vim.bo.tabstop = 2
vim.bo.shiftwidth = 2
vim.bo.softtabstop = 2

vim.wo.colorcolumn = "101"

function TSLint()
    local view = vim.fn.winsaveview()
    vim.cmd("silent execute '!./node_modules/.bin/tslint --fix -c tslint.json ' . expand('%:p')")
    vim.fn.winrestview(view)
    vim.cmd("checktime")
end

function ESLint()
    vim.cmd [[cexpr system('yarn -s lint -f unix --quiet')]]
end

require("itmecho.utils").set_autocommands(
    "itmecho_typescript",
    {
        {"BufWritePre", "*", "Prettier"}
        -- {"BufWritePost", "*.ts,*.tsx", "call v:lua.TSLint()"}
    }
)
