require("lualine").setup({
    options = {
        icons_enabled = true,
        theme = "auto",
        section_separators = { left = "", right = "" },
        component_separators = { left = "|", right = "|" }
    },
    sections = {
        lualine_z = {
            "location",
            {
                "searchcount",
                maxcount = 999,
                timeout = 500,
            }
        }
    }
})
