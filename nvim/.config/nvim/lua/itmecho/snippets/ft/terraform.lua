local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node

local fmt = require("luasnip.extras.fmt").fmt

return {
  s(
    "res",
    fmt(
      [[
          resource "{}" "{}" {{
            {}
          }}
        ]],
      {
        i(1),
        i(2),
        i(0),
      }
    )
  ),
  s(
    "mod",
    fmt(
      [[
          module "{}" {{
            source = "{}"
          }}
        ]],
      {
        i(1),
        i(0),
      }
    )
  ),
}
