local ts = require("nvim-treesitter.ts_utils")

local M = {}

function M.get_function_name()
	local current = ts.get_node_at_cursor()
	if current == nil then
		return nil
	end

	while current:type() ~= "function_declaration" do
		current = current:parent()
		if current == nil then
			return nil
		end
	end

	local bufnr = vim.api.nvim_get_current_buf()
	local fn_name = nil
	for _, node in pairs(ts.get_named_children(current)) do
		if node:type() == "identifier" then
			fn_name = vim.treesitter.query.get_node_text(node, bufnr)
		end
	end

	return fn_name
end

return M
