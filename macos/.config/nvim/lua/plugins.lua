-- PLUGIN MANAGEMENT --
local gh = function(x) return "https://github.com/" .. x end
local cb = function(x) return 'https://codeberg.org/' .. x end

vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind
        if name == "nvim-treesitter" and kind == "update" then
            if not ev.data.active then vim.cmd.packadd("nvim-treesitter") end
            vim.cmd("TSUpdate")
        elseif name == "LuaSnip" and kind == "update" then
            vim.cmd(":make install_jsregexp()")
        end
    end
})

vim.pack.add({
    gh("nvim-lualine/lualine.nvim"),
    gh("vague2k/vague.nvim"),
    gh("scrooloose/nerdtree"),
    gh("tpope/vim-dispatch"),
    gh("tpope/vim-unimpaired"),
    gh("tpope/vim-vinegar"),
    gh("tpope/vim-fugitive"),
    gh("tpope/vim-repeat"),
    gh("tpope/vim-surround"),
    gh("tpope/vim-repeat"),
    gh("guns/vim-sexp"),
    gh("lewis6991/gitsigns.nvim"),
    gh("yorickpeterse/nvim-pqf"),
    gh("easymotion/vim-easymotion"),
    gh("tomtom/tcomment_vim"),
    gh("hrsh7th/cmp-nvim-lsp"),
    gh("hrsh7th/cmp-buffer"),
    gh("hrsh7th/cmp-path"),
    gh("hrsh7th/cmp-cmdline"),
    gh("hrsh7th/nvim-cmp"),
    gh("lervag/vimtex"),
    gh("L3MON4D3/LuaSnip"),
    gh("saadparwaiz1/cmp_luasnip"),
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
    gh("nvim-neotest/nvim-nio"),
    gh("mrcjkb/haskell-tools.nvim"),
    gh("hat0uma/csvview.nvim"),
    gh("JuliaEditorSupport/julia-vim"),
    gh("Cliffback/netcoredbg-macOS-arm64.nvim"),
    gh("GustavEikaas/easy-dotnet.nvim"),
    gh("mrcjkb/rustaceanvim"),
    gh("nvim-treesitter/nvim-treesitter"),
})
