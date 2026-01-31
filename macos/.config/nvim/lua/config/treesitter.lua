-- TreeSitter SETUP --
require("nvim-treesitter").setup({
  highlight = {
    enable = true,
  },
})

-- Parse on buffer load to enable rainbow delimiters, see https://github.com/HiPhish/rainbow-delimiters.nvim/issues/187
local function on_buf_win_enter(_args)
    if vim.bo.filetype ~= "" then
        vim.treesitter.start()
    end
end

vim.api.nvim_create_autocmd("BufWinEnter", {pattern = "*", callback = on_buf_win_enter})
