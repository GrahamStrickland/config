require("nvim-dap-virtual-text").setup({
    highlight_changed_variables = true,
    all_frames = true
})

local set_virtual_text_highlights = function()
    vim.api.nvim_set_hl(0, "NvimDapVirtualText", { fg = "#87afaf", ctermfg = 109 })
    vim.api.nvim_set_hl(0, "NvimDapVirtualTextChanged", { fg = "#ffaf00", ctermfg = 214 })
    vim.api.nvim_set_hl(0, "NvimDapVirtualTextError", { fg = "#ff5f5f", ctermfg = 203 })
    vim.api.nvim_set_hl(0, "NvimDapVirtualTextInfo", { fg = "#87af87", ctermfg = 108 })
end

set_virtual_text_highlights()
vim.api.nvim_create_autocmd("ColorScheme", { callback = set_virtual_text_highlights })
