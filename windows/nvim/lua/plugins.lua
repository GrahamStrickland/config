-- PLUGIN MANAGEMENT --
-- Manage plugins with vim-plug.
local vim = vim
local Plug = vim.fn["plug#"]
vim.call("plug#begin")

Plug("vague2k/vague.nvim")
Plug("scrooloose/nerdtree")
Plug("tpope/vim-unimpaired")
Plug("tpope/vim-vinegar")
Plug("tpope/vim-fugitive")
Plug("yorickpeterse/nvim-pqf")
Plug("akinsho/git-conflict.nvim")
Plug("ctrlpvim/ctrlp.vim")
Plug("mileszs/ack.vim")
Plug("easymotion/vim-easymotion")
Plug("tomtom/tcomment_vim")
Plug("neovim/nvim-lspconfig")
Plug("nvim-lua/lsp-status.nvim")
Plug("glepnir/lspsaga.nvim")
Plug("hrsh7th/cmp-nvim-lsp")
Plug("hrsh7th/cmp-buffer")
Plug("hrsh7th/cmp-path")
Plug("hrsh7th/cmp-cmdline")
Plug("hrsh7th/nvim-cmp")
Plug("L3MON4D3/LuaSnip")
Plug("saadparwaiz1/cmp_luasnip")
Plug("nvim-lua/plenary.nvim")
Plug("nvim-telescope/telescope.nvim")
Plug("rmagatti/logger.nvim")
Plug("rmagatti/goto-preview")
Plug("mfussenegger/nvim-dap")
Plug("mfussenegger/nvim-dap-python")
Plug("nvim-neotest/nvim-nio")
Plug("rcarriga/nvim-dap-ui")
Plug("folke/neodev.nvim")
Plug("rachartier/tiny-code-action.nvim")
Plug("andrewradev/switch.vim")
Plug("hat0uma/csvview.nvim")
Plug("nvim-treesitter/nvim-treesitter", { ["do"] = function()
    vim.fn["TSUpdate"]()
end })
