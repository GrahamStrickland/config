-- PLUGIN MANAGEMENT --
-- Manage plugins with vim-plug.
local vim = vim
local Plug = vim.fn["plug#"]
vim.call("plug#begin")

Plug("vague2k/vague.nvim")
Plug("scrooloose/nerdtree")
Plug("tpope/vim-dispatch")
Plug("tpope/vim-unimpaired")
Plug("tpope/vim-vinegar")
Plug("tpope/vim-fugitive")
Plug("tpope/vim-repeat")
Plug("tpope/vim-surround")
Plug("guns/vim-sexp")
Plug("ctrlpvim/ctrlp.vim")
Plug("mileszs/ack.vim")
Plug("easymotion/vim-easymotion")
Plug("christoomey/vim-tmux-navigator")
Plug("tomtom/tcomment_vim")
Plug("neovim/nvim-lspconfig")
Plug("nvim-lua/lsp-status.nvim")
Plug("glepnir/lspsaga.nvim")
Plug("hrsh7th/cmp-nvim-lsp")
Plug("hrsh7th/cmp-buffer")
Plug("hrsh7th/cmp-path")
Plug("hrsh7th/cmp-cmdline")
Plug("hrsh7th/nvim-cmp")
Plug("lervag/vimtex")
Plug("L3MON4D3/LuaSnip")
Plug("saadparwaiz1/cmp_luasnip")
Plug("nvim-lua/plenary.nvim")
Plug("nvim-telescope/telescope.nvim")
Plug("kosayoda/nvim-lightbulb")
Plug("rmagatti/goto-preview")
Plug("mfussenegger/nvim-dap")
Plug("nvim-neotest/nvim-nio")
Plug("rcarriga/nvim-dap-ui")
Plug("folke/neodev.nvim")
Plug("Julian/lean.nvim")
Plug("rachartier/tiny-code-action.nvim")
Plug("andrewradev/switch.vim")
Plug("radenling/vim-dispatch-neovim")
Plug("clojure-vim/vim-jack-in")
Plug("Olical/conjure")
Plug("nvim-treesitter/nvim-treesitter", { ["do"] = function()
    vim.fn["TSUpdate"]()
end })

vim.call("plug#end")
