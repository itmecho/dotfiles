local ls = require("luasnip")
local s = ls.snippet
-- local sn = ls.snippet_node
-- local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
-- local f = ls.function_node
-- local c = ls.choice_node
-- local d = ls.dynamic_node
-- local r = ls.restore_node

ls.snippets = {
	go = {
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
	},
	svelte = {
		s("ncomp", {
			t('<script lang="ts">'),
			i(0),
			t({ "</script>", "", "" }),
			i(1),
		}),
	},
}
