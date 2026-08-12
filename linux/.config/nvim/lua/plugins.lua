-- Plugin management
local gh = function(x) return "https://github.com/" .. x end

vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind
        if name == "nvim-treesitter" and kind == "update" then
            if not ev.data.active then vim.cmd.packadd("nvim-treesitter") end
            vim.cmd("TSUpdate")
        end
    end
})

vim.pack.add({
    gh("wtfox/luna.nvim"),
    gh("tpope/vim-dispatch"),
    gh("tpope/vim-unimpaired"),
    gh("tpope/vim-fugitive"),
    gh("tpope/vim-rhubarb"),
    gh("tpope/vim-repeat"),
    gh("tpope/vim-surround"),
    gh("guns/vim-sexp"),
    gh("easymotion/vim-easymotion"),
    gh("tomtom/tcomment_vim"),
    gh("radenling/vim-dispatch-neovim"),
    gh("mfussenegger/nvim-dap"),
    gh("igorlfs/nvim-dap-view"),
    gh("mfussenegger/nvim-dap-python"),
    gh("neovim/nvim-lspconfig"),
    gh("nvim-treesitter/nvim-treesitter"),
})
