-- Telescope setup
require("telescope").setup {
    extensions = {
        ["ui-select"] = {
            require("telescope.themes").get_dropdown {
                layout_strategy = "vertical",
                layout_config = {
                    prompt_position = "bottom",
                    vertical = {
                        width = 0.6,
                        height = 50,
                    },
                },
            },
            specific_opts = {
                codeactions = false,
            }
        }
    }
}

require("telescope").load_extension("ui-select")
