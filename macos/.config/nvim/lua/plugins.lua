local gh = function(x) return "https://github.com/" .. x end
local cb = function(x) return 'https://codeberg.org/' .. x end

vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind
        if name == "LuaSnip" and kind == "update" then
            vim.cmd(":make install_jsregexp()")
        end
    end
})

vim.pack.add({
    gh("tpope/vim-dispatch"),
    gh("tpope/vim-unimpaired"),
    gh("tpope/vim-fugitive"),
    gh("tpope/vim-repeat"),
    gh("tpope/vim-surround"),
    gh("tpope/vim-dadbod"),
    gh("guns/vim-sexp"),
    gh("kristijanhusak/vim-dadbod-completion"),
    gh("kristijanhusak/vim-dadbod-ui"),
    gh("lewis6991/gitsigns.nvim"),
    gh("easymotion/vim-easymotion"),
    gh("tomtom/tcomment_vim"),
    gh("lervag/vimtex"),
    gh("L3MON4D3/LuaSnip"),
    gh("nvim-lua/plenary.nvim"),
    gh("Julian/lean.nvim"),
    gh("radenling/vim-dispatch-neovim"),
    gh("clojure-vim/vim-jack-in"),
    gh("Olical/conjure"),
    gh("nvim-telescope/telescope.nvim"),
    gh("nvim-telescope/telescope-ui-select.nvim"),
    gh("mfussenegger/nvim-dap"),
    cb("Jorenar/nvim-dap-disasm"),
    gh("igorlfs/nvim-dap-view"),
    gh("mfussenegger/nvim-dap-python"),
    gh("mfussenegger/nvim-jdtls"),
    gh("mrcjkb/haskell-tools.nvim"),
    gh("Cliffback/netcoredbg-macOS-arm64.nvim"),
    gh("GustavEikaas/easy-dotnet.nvim"),
})
