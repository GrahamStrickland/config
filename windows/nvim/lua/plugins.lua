-- PLUGIN MANAGEMENT --
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
    gh("nvim-lualine/lualine.nvim"),
    gh("vague2k/vague.nvim"),
    gh("scrooloose/nerdtree"),
    gh("tpope/vim-dispatch"),
    gh("tpope/vim-unimpaired"),
    gh("tpope/vim-vinegar"),
    gh("tpope/vim-fugitive"),
    gh("tpope/vim-repeat"),
    gh("tpope/vim-surround"),
    gh("lewis6991/gitsigns.nvim"),
    gh("yorickpeterse/nvim-pqf"),
    gh("easymotion/vim-easymotion"),
    gh("tomtom/tcomment_vim"),
    gh("hrsh7th/cmp-nvim-lsp"),
    gh("hrsh7th/cmp-buffer"),
    gh("hrsh7th/cmp-path"),
    gh("hrsh7th/cmp-cmdline"),
    gh("hrsh7th/nvim-cmp"),
    gh("nvim-lua/plenary.nvim"),
    gh("nvim-telescope/telescope.nvim"),
    gh("nvim-telescope/telescope-ui-select.nvim"),
    gh("mfussenegger/nvim-dap"),
    gh("mfussenegger/nvim-dap-python"),
    gh("nvim-neotest/nvim-nio"),
    gh("rcarriga/nvim-dap-ui"),
    gh("hat0uma/csvview.nvim"),
    gh("GustavEikaas/easy-dotnet.nvim"),
    gh("nvim-treesitter/nvim-treesitter"),
})
