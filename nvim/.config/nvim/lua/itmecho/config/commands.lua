local function parse_value(value)
	if value == "true" then
		return true
	end
	if value == "false" then
		return false
	end

	local num = tonumber(value, 10)
	if num ~= nil then
		return num
	end

	return value
end

local function parse_args(args)
	local opts = {}
	for part in string.gmatch(args, "[^%s]+") do
		for key, value in string.gmatch(part, "(.*)=(.*)") do
			opts[key] = parse_value(value)
		end
	end
	return opts
end

vim.api.nvim_create_user_command("GenSolidJSComponent", function(opts)
	local args = parse_args(opts.args)
	require("itmecho.gen").create_component(args)
end, { nargs = "*" })

vim.api.nvim_create_user_command("CreatePR", function()
	local octo = require("octo.commands").octo
	octo("pr", "create", "draft")
	-- octo("reviewer", "add", "supersparks/leibniz")
	octo("label", "add", "team/leibniz")
end, {})

vim.api.nvim_create_user_command("Reset", function()
	local u = require("itmecho.utils")
	u.delete_buffers()
	u.stop_all_lsp_clients()

	vim.cmd([[ tcd $CLOUDPATH ]])
end, {})

vim.api.nvim_create_user_command("GitFixup", require("itmecho.git").fixup, {})
