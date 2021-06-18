require("itmecho.utils").set_autocommands(
    "itmecho_markdown",
    {{"BufWritePre", "*.md", "lua require('itmecho.utils').run_format_command('markdownfmt')"}}
)
