-- PLUGIN MANAGEMENT --
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
    gh("tpope/vim-rhubarb"),
    gh("tpope/vim-repeat"),
    gh("tpope/vim-surround"),
    gh("tpope/vim-dadbod"),
    gh("kristijanhusak/vim-dadbod-completion"),
    gh("kristijanhusak/vim-dadbod-ui"),
    gh("neovim/nvim-lspconfig"),
    gh("nvim-treesitter/nvim-treesitter"),
    gh("lewis6991/gitsigns.nvim"),
    gh("easymotion/vim-easymotion"),
    gh("tomtom/tcomment_vim"),
    gh("mfussenegger/nvim-dap"),
    cb("Jorenar/nvim-dap-disasm"),
    gh("nvim-neotest/nvim-nio"),
    gh("rcarriga/nvim-dap-ui"),
    gh("theHamsta/nvim-dap-virtual-text"),
    gh("mfussenegger/nvim-dap-python"),
})
