-- MacOS Neovim Configuration
-- KEY MAPPINGS --
-- Map the leader key to a space.
vim.g.mapleader = "<space>"
vim.g.maplocalleader = "<space><space>"

-- Save a file with leader-w.
vim.api.nvim_set_keymap(
  "n",
  "<leader>w",
  ":w<cr>",
  { noremap = true }
)

-- Open NERDTree for viewing files.
vim.api.nvim_set_keymap(
  "n",
  "<leader>n",
  ":NERDTreeToggle<cr>",
  { noremap = true }
)

-- Map Ctrlp buffer mode to Ctrl + B
vim.api.nvim_set_keymap(
    "n",
    "<c-b>",
    "CtrlPBuffer<cr>",
    { noremap = true }
)

-- Fast split navigation with <Ctrl> + hjkl
vim.api.nvim_set_keymap(
  "n",
  "<c-h>",
  "<c-w><c-h>",
  { noremap = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<c-j>",
  "<c-w><c-j>",
  { noremap = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<c-k>",
  "<c-w><c-k>",
  { noremap = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<c-l>",
  "<c-w><c-l>",
  { noremap = true }
)

-- Page down/up and center
vim.api.nvim_set_keymap(
  "n",
  "<c-d>",
  "<c-d>zz",
  { noremap = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<c-u>",
  "<c-u>zz",
  { noremap = true }
)

-- Use ; in addition to : to type commands.
vim.api.nvim_set_keymap(
  "n",
  ";",
  ":",
  { noremap = true }
)

-- Immediately add a closing quotes or braces in insert mode.
vim.api.nvim_set_keymap(
  "i",
  "(",
  "()<esc>i",
  { noremap = true }
)
vim.api.nvim_set_keymap(
  "i",
  "{",
  "{}<esc>i",
  { noremap = true }
)
vim.api.nvim_set_keymap(
  "i",
  "[",
  "[]<esc>i",
  { noremap = true }
)

-- Remap terminal mode escape.
vim.api.nvim_set_keymap(
  "t",
  "<esc>",
  "<c-\\><c-n>",
  { noremap = true }
)

-- PLUGIN MANAGEMENT --
-- Manage plugins with vim-plug.
local vim = vim
local Plug = vim.fn['plug#']
vim.call('plug#begin')

Plug('scrooloose/nerdtree')
Plug('tpope/vim-unimpaired')
Plug('tpope/vim-vinegar')
Plug('tpope/vim-fugitive')
Plug('ctrlpvim/ctrlp.vim')
Plug('mileszs/ack.vim')
Plug('easymotion/vim-easymotion')
Plug('doums/darcula')
Plug('tomasiser/vim-code-dark')
Plug('morhetz/gruvbox')
Plug('christoomey/vim-tmux-navigator')
Plug('tomtom/tcomment_vim')             -- For commenting motions
Plug('neovim/nvim-lspconfig')
Plug('nvim-lua/lsp-status.nvim')
Plug('glepnir/lspsaga.nvim')
Plug('hrsh7th/nvim-cmp')                -- For LSP completion
Plug('hrsh7th/cmp-nvim-lsp')
Plug('hrsh7th/cmp-buffer')
Plug('hrsh7th/vim-vsnip')               -- For snippets
Plug('nvim-telescope/telescope.nvim')   -- For Loogle search
Plug('kosayoda/nvim-lightbulb')
Plug('rmagatti/goto-preview')
Plug('mfussenegger/nvim-dap')
Plug('Julian/lean.nvim')
Plug('nvim-lua/plenary.nvim')
Plug('andrewradev/switch.vim')          -- For Lean switch support
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = function()
    vim.fn['TSUpdate']()
end })

vim.call('plug#end')

-- OPTION SETUP --
vim.g.NERDTreeHijackNetrw = 0

vim.opt.number = true           -- Add line numbers to document.
vim.opt.relativenumber = true   -- Add relative line numbers to document.
vim.opt.autoread = true         -- Automatically reload files.
vim.opt.autoindent = true	    -- Respect indentation when starting a new line.
vim.opt.expandtab = true		-- Expand tabs to spaces. Essential in Python.
vim.opt.tabstop = 4			    -- Number of spaces tab is counted for.
vim.opt.shiftwidth = 4		    -- Number of spaces to use for autoindent.
vim.opt.background = "dark"     -- Set to dark mode.
vim.opt.hlsearch = true         -- Highlight search results.
vim.opt.incsearch = true        -- Show where search pattern matches.
vim.opt.clipboard = "unnamed"   -- Copy into system (*) register.

-- Adapted for MacOS from 
-- https://toddknutson.bio/posts/how-to-enable-neovim-undo-backup-and-swap-files-when-switching-linux-groups/
USER = os.getenv("USER")
SWAPDIR = "/Users/" .. USER .. "/nvim/swap//"
BACKUPDIR = "/Users/" .. USER .. "/nvim/backup//"
UNDODIR = "/Users/" .. USER .. "/nvim/undo//"

if vim.fn.isdirectory(SWAPDIR) == 0 then
	vim.fn.mkdir(SWAPDIR, "p", "0o700")
end

if vim.fn.isdirectory(BACKUPDIR) == 0 then
	vim.fn.mkdir(BACKUPDIR, "p", "0o700")
end

if vim.fn.isdirectory(UNDODIR) == 0 then
	vim.fn.mkdir(UNDODIR, "p", "0o700")
end

-- Enable swap, backup, and persistant undo
vim.opt.directory = SWAPDIR
vim.opt.backupdir = BACKUPDIR
vim.opt.undodir = UNDODIR
vim.opt.swapfile = true
vim.opt.backup = true
vim.opt.undofile = true

-- Append backup files with timestamp
vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function()
		local extension = "~" .. vim.fn.strftime("%Y-%m-%d-%H%M%S")
		vim.o.backupext = extension
	end,
})

-- COMMANDS --
vim.cmd('colorscheme gruvbox')

require('lean').setup({
    lsp = { on_attach = on_attach },
    mappings = true,
})

require("nvim-lightbulb").setup({
    autocmd = { enabled = true }
})

require("goto-preview").setup({})

-- LSP setup
require'lspconfig'.clangd.setup{}
require'lspconfig'.hls.setup{}
require'lspconfig'.pyright.setup{}

