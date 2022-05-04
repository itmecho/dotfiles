local Path = require("plenary.path")

local M = {}

local function gen_component_index(dir, name)
  local path = dir:joinpath("index.tsx")
  path:write(
    string.format(
      [[import %s from './%s';

export default %s;]],
      name,
      name,
      name
    ),
    "w"
  )
  return path
end

local function gen_component_file(dir, name, opts)
  local path = dir:joinpath(name .. ".tsx")
  local args = { name }

  local tpl = ""

  if opts.cssModule then
    table.insert(args, name)
    tpl = "import styles from './%s.module.css';\n\n"
  elseif opts.makeStyles then
    tpl = "import useStyles from './styles';\n\n"
  end

  tpl = tpl .. "export default function %s() {\n"
  if opts.makeStyles then
    tpl = tpl .. "  const classes = useStyles();\n\n"
  end
  tpl = tpl .. "  return <></>;\n}"

  path:write(string.format(tpl, unpack(args)), "w")
  return path
end

local function gen_component_css_module(dir, name)
  local path = dir:joinpath(name .. ".module.css")
  path:write("", "w")
  return path
end

local function gen_component_make_styles(dir, name)
  local path = dir:joinpath("styles.tsx")
  path:write(
    string.format(
      [[import { makeStyles, Theme } from '@material-ui/core/styles';

export const useStyles = makeStyles((theme: Theme) => ({

});

export default useStyles;]],
      name,
      name,
      name
    ),
    "w"
  )
  return path
end

function M.create_component(opts)
  opts = vim.tbl_deep_extend("keep", opts or {}, {
    cssModule = false,
    makeStyles = false,
  })

  local dir = vim.fn.input({ prompt = "Component folder: ", default = "src/components/", completion = "dir" })
  local base_dir = Path:new(dir)
  if not base_dir:exists() then
    base_dir:mkdir({ parents = true })
  end
  local parts = base_dir:_split()
  local component_name = parts[#parts]

  gen_component_index(base_dir, component_name)
  local component_path = gen_component_file(base_dir, component_name, opts)

  if opts.cssModule then
    gen_component_css_module(base_dir, component_name)
  end

  if opts.makeStyles then
    gen_component_make_styles(base_dir, component_name)
  end

  vim.cmd("e " .. component_path.filename)
end

return M
