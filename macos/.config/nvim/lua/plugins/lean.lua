-- LEAN4 SETUP
local lean = require("lean")
local telescope = require("telescope")
local bufnr = vim.api.nvim_get_current_buf()

lean.setup { mappings = true }

vim.keymap.set(
    "n",
    "<leader>ls",
    function() telescope.extensions.loogle.loogle() end,
    { noremap = true, silent = true, buffer = bufnr, }
)
