-- Show messages in a floating window that fades out, since cmdheight is 0.
-- The default ("cmd") expands the cmdline and can open the pager on repeated messages.
require("vim._core.ui2").enable({ msg = { target = "msg" } })

vim.o.background = "dark"
vim.cmd.colorscheme("everforest")
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { link = "Normal" })
vim.o.winborder = "rounded"
