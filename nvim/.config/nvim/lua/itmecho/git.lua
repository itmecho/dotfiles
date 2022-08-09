local ts = require("itmecho.telescope")
local M = {}

M.fixup = function()
	-- TODO check if there are staged changes
	ts.pick_commit(function(commit_hash)
		vim.fn.system("git commit --fixup " .. commit_hash)
		vim.fn.system("git rebase " .. commit_hash .. "~1")
	end)
end

return M
