local function lsp_segment()
    local status_prefix = "  "
    local ok_message = "  "

    if #vim.lsp.buf_get_clients() == 0 then
        return ""
    end

    local msgs = {}
    local buf_messages = vim.lsp.util.get_progress_messages()

    for _, msg in ipairs(buf_messages) do
        local client_name = "[" .. msg.name .. "]"
        local contents = ""
        if msg.progress then
            if msg.title == "Error loading workspace" then
                print(msg.message)
            end

            contents = msg.title

            if msg.message then
                contents = contents .. ": " .. msg.message
            end

            if msg.percentage then
                contents = contents .. " (" .. msg.percentage .. ")"
            end
        elseif msg.status then
            contents = msg.content
            if msg.uri then
                local filename = vim.uri_to_fname(msg.uri)
                filename = vim.fn.fnamemodify(filename, ":~:.")
                local space = math.min(60, math.floor(0.6 * vim.fn.winwidth(0)))
                if #filename > space then
                    filename = vim.fn.pathshorten(filename)
                end

                contents = "(" .. filename .. ") " .. contents
            end
        else
            contents = msg.content
        end

        table.insert(msgs, client_name .. " " .. contents)
    end
    local base_status = " " .. table.concat(msgs, " ")

    if base_status ~= " " then
        return status_prefix .. base_status .. " "
    end

    return ok_message
end

require("lualine").setup(
    {
        options = {
            icons_enabled = true,
            theme = vim.env.THEME:lower()
        },
        sections = {
            lualine_a = {"mode"},
            lualine_b = {"filetype"},
            lualine_c = {"filename"},
            lualine_x = {
                {lsp_segment},
                {"diagnostics", sources = {"nvim_lsp"}}
            },
            lualine_y = {"branch"},
            lualine_z = {"location"}
        }
    }
)
