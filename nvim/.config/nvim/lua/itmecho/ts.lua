local actions = require("telescope.actions")
local actions_state = require("telescope.actions.state")
local ts = require("nvim-treesitter.ts_utils")
local ht = require("harpoon.term")
local generic_picker = require("itmecho.telescope").generic_picker

local M = {}

function M.get_test_name()
	local current = ts.get_node_at_cursor()
	if current == nil then
		return nil
	end

	local bufnr = vim.api.nvim_get_current_buf()
	local get_node_text = function(node)
		return vim.treesitter.get_node_text(node, bufnr)
	end
	local children = ts.get_named_children
	local test_parts = {}

	while current ~= nil do
		local type = current:type()
		if type == "function_declaration" then
			for _, node in pairs(children(current)) do
				if node:type() == "identifier" then
					table.insert(test_parts, 1, get_node_text(node))
				end
			end
		elseif type == "call_expression" then
			local child_nodes = children(current)
			if #child_nodes == 2 then
				local fn = get_node_text(child_nodes[1])
				if fn == "t.Run" then
					local args = children(child_nodes[2])
					local txt = get_node_text(args[1])
					txt = txt:gsub('"', ""):gsub(" ", "_")
					table.insert(test_parts, 1, txt)
				end
			end
		end
		current = current:parent()
	end

	local test_name = nil
	if #test_parts > 0 then
		test_name = table.concat(test_parts, "/")
	end

	return test_name
end

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

local test_names = vim.treesitter.parse_query(
	"go",
	[[
(function_declaration
  name: (identifier) @func

  (#match? @func "^Test.*")

  body: (block
    (call_expression
			function: (selector_expression
				operand: (identifier) @operand (#eq? @operand "t")
				field: (field_identifier) @field (#eq? @field "Run")
			)
			(argument_list (interpreted_string_literal) @func.test)
		)
	)
)
]]
)

function M.gotest()
	local bufnr = vim.api.nvim_get_current_buf()
	local parser = vim.treesitter.get_parser(bufnr, "go", {})
	local tree = parser:parse()[1]
	local root = tree:root()
	local test_paths = {}
	local funcs = {}
	for id, node in test_names:iter_captures(root, bufnr, 0, -1) do
		local name = test_names.captures[id]
		local txt = vim.treesitter.get_node_text(node, bufnr)
		if name == "func" and funcs[txt] == nil then
			funcs[txt] = node
		end
		if name == "func.test" then
			for func_name, func in pairs(funcs) do
				local is_parent = require("nvim-treesitter.ts_utils").is_parent(func:parent(), node)
				if is_parent then
					local test_name = string.gsub(txt, '"', "")
					test_name = string.gsub(test_name, " ", "_")
					local test_path = func_name .. "/" .. test_name
					table.insert(test_paths, test_path)
				end
			end
		end
	end

	generic_picker({
		prompt_title = "Test",
		items = test_paths,
		mappings = function(prompt_bufnr, map)
			map("i", "<CR>", function()
				actions.close(prompt_bufnr)
				local test_name = actions_state.get_selected_entry().value
				local path = vim.fn.expand("%:h")
				ht.gotoTerminal(1)
				ht.sendCommand(1, "go test -count=1 ./" .. path .. '/... -run "' .. test_name .. '"')
				vim.cmd("norm G")
			end)
			return true
		end,
	})
end

return M
