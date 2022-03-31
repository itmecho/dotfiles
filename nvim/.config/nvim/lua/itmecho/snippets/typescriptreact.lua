return {
  s(
    "reactfunctioncomponent",
    fmt(
      [[
        export default function {}() {{
          return <>{}</>;
        }}
      ]],
      { i(1), i(0) }
    )
  ),
  s(
    "remixroute",
    fmt(
      [[
        import {{ ActionFunction, LoaderFunction }} from "remix";

        export const loader: LoaderFunction = async ({{request}}) => {{
          return {{}};
        }};

        export const action: ActionFunction = async ({{request}}) => {{
          return {{}};
        }};

        export default function {}() {{
          return <>{}</>;
        }}
      ]],
      { i(1), i(0) }
    )
  ),
  s(
    "remixloader",
    fmt(
      [[
        export const loader: LoaderFunction = async ({{request}}) => {{
          {}
          return {{}};
        }};

      ]],
      i(0)
    )
  ),
  s(
    "remixaction",
    fmt(
      [[
        export const action: ActionFunction = async ({{request}}) => {{
          {}
          return {{}};
        }};

      ]],
      i(0)
    )
  ),
}
