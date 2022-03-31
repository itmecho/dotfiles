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
