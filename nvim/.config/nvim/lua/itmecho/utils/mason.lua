local registry = require("mason-registry")

local function ensure_installed(packages)
	for _, pkg in ipairs(packages) do
		if not registry.is_installed(pkg) then
			require("mason-registry." .. pkg):install()
		end
	end
end

return {
	ensure_installed = ensure_installed,
}
