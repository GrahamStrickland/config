-- TreeSitter SETUP --
require("nvim-treesitter").setup({
  highlight = {
    enable = true,
  },
})

whitelist = { 
    "bash",
    "c",
    "c_sharp",
    "clojure",
    "cmake",
    "commonlisp",
    "cpp",
    "haskell",
    "java",
    "javascript",
    "julia",
    "latex",
    "lua",
    "prolog",
    "python",
    "query",
    "r",
    "rust",
    "sql",
    "toml",
    "typescript",
    "vim"
}           

-- Parse on buffer load to enable rainbow delimiters, see https://github.com/HiPhish/rainbow-delimiters.nvim/issues/187
local function on_buf_win_enter(_args)
    for _, filetype in pairs(whitelist) do
        if vim.bo.filetype == filetype then
            vim.treesitter.start()
        end
    end
end

vim.api.nvim_create_autocmd("BufWinEnter", {pattern = "*", callback = on_buf_win_enter})
