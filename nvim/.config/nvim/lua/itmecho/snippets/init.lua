local ls = require("luasnip")

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

local function ft(name)
  return require("itmecho.snippets.ft." .. name)
end

ls.snippets = {
  all = {
    s("uuidgen", {
      f(function()
        return vim.trim(vim.fn.system("uuidgen"))
      end),
    }),
    s("todo", {
      t("TODO(iain): "),
      i(0),
    }),
  },
  go = ft("go"),
  terraform = ft("terraform"),
  typescriptreact = ft("typescriptreact"),
}
