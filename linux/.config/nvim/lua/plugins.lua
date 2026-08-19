-- Plugin management
local gh = function(x) return "https://github.com/" .. x end
local cb = function(x) return 'https://codeberg.org/' .. x end

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
    gh("nvim-mini/mini.icons"),
    gh("nvim-tree/nvim-web-devicons"),
    gh("neovim/nvim-lspconfig"),
    gh("nvim-treesitter/nvim-treesitter"),
    gh("radenling/vim-dispatch-neovim"),
    gh("nvim-lua/plenary.nvim"),
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
})
