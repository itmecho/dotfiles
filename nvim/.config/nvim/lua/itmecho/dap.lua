local widgets = require("dap.ui.widgets")

local M = {}

local sidebar = nil
local sidebar_opts = {
    width = 100,
    colorcolumn = "",
    list = false
}

function M.toggle_sidebar()
    sidebar = sidebar or widgets.sidebar(widgets.scopes, sidebar_opts)
    sidebar.toggle()
end

function M.load_envfile(component)
    local path = vim.env.CLOUDPATH .. "/.orca/" .. component .. ".env"
    for line in io.lines(path) do
        for k, v in line:gmatch("(.+)=(.+)") do
            vim.env[k] = v
        end
    end
end

return M
