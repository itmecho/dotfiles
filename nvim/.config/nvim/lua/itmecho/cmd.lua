local Job = require "plenary.job"

local M = {}

function M.run_in_popup(command)
    local buf = vim.api.nvim_create_buf(false, true)
    local ui = vim.api.nvim_list_uis()[1]
    local win =
        vim.api.nvim_open_win(
        buf,
        1,
        {
            relative = "editor",
            width = math.floor(ui.width / 2),
            height = math.floor(ui.height / 2),
            row = 1,
            col = ui.width
        }
    )
    -- vim.cmd [[term]]
    -- vim.api.nvim_chan_send(vim.b.terminal_job_id, "clear && " .. command .. "\n")
    local chan = vim.api.nvim_open_term(buf, {})
    local write = function(_, data)
        vim.api.nvim_chan_send(chan, data .. "\r\n")
    end
    Job:new(
        {
            command = "/bin/sh",
            args = {"-c", "./barx.sh proto"},
            cwd = "/home/iain/src/CloudExperiments",
            on_stdout = vim.schedule_wrap(write),
            on_stderr = vim.schedule_wrap(write)
        }
    ):start()
end

return M
