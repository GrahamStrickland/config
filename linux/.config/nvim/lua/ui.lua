require("vim._core.ui2").enable({})

vim.o.background = "dark"
vim.cmd("colorscheme retrobox")
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.o.winborder = "rounded"
