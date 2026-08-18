local gh = function(x) return "https://github.com/" .. x end
local cb = function(x) return 'https://codeberg.org/' .. x end

vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind
        if name == "LuaSnip" and kind == "update" then
            vim.cmd(":make install_jsregexp()")
        end
        if name == "nvim-treesitter" and kind == "update" then
            vim.cmd("TSUpdate")
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
    gh("tomtom/tcomment_vim"),
    gh("easymotion/vim-easymotion"),
    gh("kristijanhusak/vim-dadbod-completion"),
    gh("kristijanhusak/vim-dadbod-ui"),
    gh("neovim/nvim-lspconfig"),
    gh("nvim-treesitter/nvim-treesitter"),
    gh("lewis6991/gitsigns.nvim"),
    gh("lervag/vimtex"),
    gh("L3MON4D3/LuaSnip"),
    gh("nvim-lua/plenary.nvim"),
    gh("Julian/lean.nvim"),
    gh("nvim-telescope/telescope.nvim"),
    gh("nvim-telescope/telescope-ui-select.nvim"),
    gh("stevearc/oil.nvim"),
    gh("nvim-lualine/lualine.nvim"),
    gh("mfussenegger/nvim-dap"),
    cb("Jorenar/nvim-dap-disasm"),
    gh("nvim-neotest/nvim-nio"),
    gh("rcarriga/nvim-dap-ui"),
    gh("theHamsta/nvim-dap-virtual-text"),
    gh("mfussenegger/nvim-dap-python"),
    gh("mfussenegger/nvim-jdtls"),
    gh("mrcjkb/haskell-tools.nvim"),
    gh("Cliffback/netcoredbg-macOS-arm64.nvim"),
})
