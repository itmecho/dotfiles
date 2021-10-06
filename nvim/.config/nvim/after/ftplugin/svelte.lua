require("itmecho.utils").set_autocommands(
    "formatting",
    {
        {"BufWritePost", "*", "Neoformat | w"}
    }
)
