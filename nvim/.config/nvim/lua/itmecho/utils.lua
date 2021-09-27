local M = {}

-- TODO Move this to a more appropriate file and make it global
-- so we can call v:lua.RunFormatCommand()
M.run_format_command = function(cmd)
    local view = vim.fn.winsaveview()
    vim.cmd('silent execute "%!' .. cmd .. '"')
    if vim.v.shell_error ~= 0 then
        vim.cmd("undo")
    end
    vim.fn.winrestview(view)
end

M.set_autocommands = function(group_name, autocommands)
    vim.cmd("augroup " .. group_name)
    vim.cmd("autocmd!")
    for _, a in ipairs(autocommands) do
        vim.cmd("autocmd " .. table.concat(a, " "))
    end
    vim.cmd("augroup END")
end

M.keymap = function(mode, lhs, rhs, extra_opts)
    extra_opts = extra_opts or {}
    local opts = {
        noremap = true,
        silent = true
    }
    for k, v in pairs(extra_opts) do
        opts[k] = v
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
end

M.close_all_other_buffers = function()
    local bufs = vim.api.nvim_list_bufs()
    local current_buf = vim.api.nvim_get_current_buf()
    local count = 0
    for _, buf in pairs(bufs) do
        -- Only close listed buffers
        local listed = vim.api.nvim_buf_get_option(buf, "buflisted")

        -- Don't close current buffer
        if buf ~= current_buf and listed then
            vim.api.nvim_buf_delete(buf, {})
            count = count + 1
        end
    end

    print("closed " .. count .. " buffers")
end

function M.install_lsp_servers()
    local lspinstall = require("lspinstall")
    local installed_servers = lspinstall.installed_servers()
    local wanted = {"go", "lua", "rust", "tailwindcss", "typescript"}

    for _, server in pairs(wanted) do
        local is_installed = false
        for _, installed in pairs(installed_servers) do
            if server == installed then
                is_installed = true
            end
        end

        if not is_installed then
            require("lspinstall").install_server(server)
        end
    end
end

return M
