-- LEAN4 SETUP
local lean = require("lean")
local telescope = require("telescope")

lean.setup { mappings = true }

vim.keymap.set(
    "n",
    "<leader>ls",
    function() telescope.extensions.loogle.loogle() end,
    { noremap = true, silent = true }
)
