local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

local fmta = require("luasnip.extras.fmt").fmta

return {
  s("dbg", {
    t('fmt.Printf("%+v\\n", '),
    i(1),
    t(")"),
  }),

  -- Snippet for creating a new main package
  s("pmain", {
    t({ "package main", "", "func main() {", "\t" }),
    i(0),
    t({ "", "}" }),
  }),

  -- Snippet for adding JSON struct tag
  s("`j", {
    t('`json:"'),
    i(0),
    t('"`'),
  }),

  -- Error checks
  s(
    "iferr",
    fmta(
      [[
        if err != nil {
          return <>
        }
      ]],
      i(0)
    )
  ),
  s(
    "iferris",
    fmta(
      [[
        if errors.Is(err, <>) {
          return <>
        }
      ]],
      {
        i(1),
        i(0),
      }
    )
  ),
}
