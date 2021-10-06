local Path = require("plenary.path")

local M = {}

local notes_dir = Path:new(os.getenv("HOME"), "notes")

local function open_win()
    local ui = vim.api.nvim_list_uis()[1]
    local winopts = {
        relative = "editor",
        width = ui.width - 20,
        height = ui.height - vim.o.cmdheight - 3 - 6,
        row = 3,
        col = 11,
        style = "minimal",
        border = "single"
    }
    local bufh = vim.api.nvim_create_buf(true, false)
    local winh = vim.api.nvim_open_win(bufh, true, winopts)

    vim.cmd [[ autocmd InsertLeave <buffer> :w! ]]
    vim.cmd [[ autocmd WinLeave <afile> :w! ]]
    return {
        bufh = bufh,
        winh = winh
    }
end

function M.create()
    local title = vim.fn.input("Title: ")
    local date = os.date("%Y-%m-%d")
    local normalised_title = title:lower():gsub("%s+", "-")
    local filename = date .. "-" .. normalised_title .. ".md"
    local full_path = notes_dir:joinpath(filename)

    local heading = "#"
    for word in title:gmatch("%S+") do
        heading = heading .. " " .. (word:gsub("^%l", string.upper))
    end

    local win = open_win()
    vim.cmd("edit " .. full_path.filename)
    if full_path:exists() ~= true then
        vim.api.nvim_buf_set_lines(win.bufh, 0, 1, false, {heading})
    end
end

function M.list()
    require("telescope.builtin").find_files({prompt_title = "Notes", cwd = notes_dir.filename})
end

return M
