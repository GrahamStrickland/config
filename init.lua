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

-- OPTION SETUP --
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
Plug('junegunn/vim-plug')
Plug('doums/darcula')
Plug('tomasiser/vim-code-dark')
Plug('morhetz/gruvbox')
Plug('christoomey/vim-tmux-navigator')
Plug('tomtom/tcomment_vim')             -- For commenting motions
Plug('nvim-telescope/telescope.nvim')   -- For Loogle search
Plug('kosayoda/nvim-lightbulb')
Plug('rmagatti/goto-preview')
Plug('mfussenegger/nvim-dap')

-- LSP support
Plug('neovim/nvim-lspconfig')
Plug('kabouzeid/nvim-lspinstall')
Plug('nvim-lua/lsp-status.nvim')
Plug('glepnir/lspsaga.nvim')
Plug('hrsh7th/nvim-cmp')                -- For LSP completion
Plug('hrsh7th/cmp-nvim-lsp')
Plug('hrsh7th/cmp-buffer')
Plug('hrsh7th/vim-vsnip')               -- For snippets

-- Lean support (https://github.com/Julian/lean.nvim/)
Plug('Julian/lean.nvim')
Plug('neovim/nvim-lspconfig')
Plug('nvim-lua/plenary.nvim')
Plug('andrewradev/switch.vim')          -- For Lean switch support

-- Treesitter
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = function()
    vim.fn['TSUpdate']()
end })

vim.call('plug#end')

-- COMMANDS --
vim.cmd('colorscheme gruvbox')

-- OLD VIM COMMANDS --
vim.cmd([[
" Set up persistent undo across all files.
set undofile
if !isdirectory("$HOME/.vim/undodir")
    call mkdir("$HOME/.vim/undodir", "p")
endif
set undodir="$HOME/.vim/undodir"

packloadall             " Load all plugins.
silent! helptags ALL    " Load help files for all plugins.

command! Bd :bp | :sp | :bn | :bd " Close buffer without closing window.

set foldmethod=indent

set wildmenu                    " Enable enhanced tab autocomplete
set wildmode=list:longest,full  " Complete till longest string,
                                " then open the wildmenu.

let NERDTreeHijackNetrw = 0

set clipboard=unnamed           " Copy into system (*) register.

" Install vim-plug if it's not already installed.
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.github.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Exuberant Ctags settings
" Look for a tags file recursively in parent directories.
set tags=tags;
"Regenerate tags when saving Python files.
autocmd BufWritePost *.c,*.cpp,*.h,*.java,*.class,*.py silent! !ctags -R &   
]])

require('lean').setup({
  lsp = { on_attach = on_attach },
  mappings = true,
})

require("nvim-lightbulb").setup({
  autocmd = { enabled = true }
})

require("goto-preview").setup({})

local function setup_servers()
    require'lspinstall'.setup()
    local servers = require'lspinstall'.installed_servers()
    for _, server in pairs(servers) do
        require'lspconfig'[server].setup{}
    end
end

setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require'lspinstall'.post_install_hook = function ()
    setup_servers() -- reload installed servers
    vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end

