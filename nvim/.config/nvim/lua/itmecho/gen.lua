local Path = require("plenary.path")

local M = {}

function M.create_component(opts)
  opts = vim.tbl_deep_extend("keep", opts, {
    cssModule = false,
  })

  local dir = vim.fn.input({ prompt = "Component folder: ", completion = "dir" })
  local base_dir = Path:new(dir)
  if not base_dir:exists() then
    base_dir:mkdir({ parents = true })
  end
  local parts = base_dir:_split()
  local component_name = parts[#parts]

  local index = base_dir:joinpath("index.tsx")
  index:write(
    string.format(
      [[import %s from './%s';

export default %s;]],
      component_name,
      component_name,
      component_name
    ),
    "w"
  )

  local component = base_dir:joinpath(component_name .. ".tsx")
  component:write(
    string.format(
      [[export default function %s() {
  return <></>;
}]],
      component_name
    ),
    "w"
  )

  if opts.cssModule then
    local cssModule = base_dir:joinpath(component_name .. ".module.css")
    cssModule:write("", "w")
  end

  vim.cmd("e " .. component.filename)
end

return M
