print("loaded all snippets")
return {
  s("uuidgen", {
    f(function()
      return vim.trim(vim.fn.system("uuidgen"))
    end),
  }),
  s("todo", {
    t("TODO(iain): "),
    i(0),
  }),
}
