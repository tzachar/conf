require("nvim-surround").buffer_setup({
    surrounds = {
        ["p"] = {
            add = { "print(", ")" },
            find = "print%b()",
            delete = "^(print%()().-(%))()$",
            change = {
                target = "^(print%()().-(%))()$",
            },
        },
    }
})
