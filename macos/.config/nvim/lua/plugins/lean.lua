-- LEAN4 SETUP
local telescope = require("telescope")

vim.g.lean_config = { mappings = true }

vim.keymap.set(
    "n",
    "<leader>ls",
    function() telescope.extensions.loogle.loogle() end,
    { noremap = true, silent = true }
)
