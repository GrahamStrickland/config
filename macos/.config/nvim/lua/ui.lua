require("vim._core.ui2").enable({})

vim.o.background = "dark"
vim.cmd.colorscheme("everforest")
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { link = "Normal" })
vim.o.winborder = "rounded"
