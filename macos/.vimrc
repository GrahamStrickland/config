" MacOS Neovim Configuration
" Map the leader key to a space.
let mapleader = "\<space>"
let maplocalleader = "\<space>\<space>"

" Save a file with leader-w.
noremap <leader>w :w<cr>

noremap <leader>n : NERDTreeToggle<cr>

syntax on			        " Enable syntax highlighting.
filetype plugin indent on	" Enable file type based indentation.

set number              " Add line numbers to document.
set relativenumber      " Add relative line numbers to document.
set autoread            " Automatically reload files.
set autoindent			" Respect indentation when starting a new line.
set expandtab			" Expand tabs to spaces. Essential in Python.
set tabstop=4			" Number of spaces tab is counted for.
set shiftwidth=4		" Number of spaces to use for autoindent.
set backspace=2			" Fix backspace behavior on most terminals.
set background=dark     " Set to dark mode.

" Set up persistent undo across all files.
set undofile
if !isdirectory("$HOME/.vim/undodir")
    call mkdir("$HOME/.vim/undodir", "p")
endif
set undodir="$HOME/.vim/undodir"

packloadall             " Load all plugins.
silent! helptags ALL    " Load help files for all plugins.

" Fast split navigation with <Ctrl> + hjkl
noremap <c-h> <c-w><c-h>
noremap <c-j> <c-w><c-j>
noremap <c-k> <c-w><c-k>
noremap <c-l> <c-w><c-l>

" Page down/up and center
noremap <c-d> <c-d>zz
noremap <c-u> <c-u>zz

command! Bd :bp | :sp | :bn | :bd " Close buffer without closing window.

set foldmethod=indent

set wildmenu                    " Enable enhanced tab autocomplete
set wildmode=list:longest,full  " Complete till longest string,
                                " then open the wildmenu.

let NERDTreeHijackNetrw = 0

nnoremap <C-b> :CtrlPBuffer<cr> " Map Ctrlp buffer mode to Ctrl + B.

set hlsearch
set incsearch

set clipboard=unnamed           " Copy into system (*) register.

" Manage plugins with vim-plug.
call plug#begin()

Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-fugitive'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mileszs/ack.vim'
Plug 'easymotion/vim-easymotion'
Plug 'junegunn/vim-plug'
Plug 'doums/darcula'
Plug 'tomasiser/vim-code-dark'
Plug 'morhetz/gruvbox'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'christoomey/vim-tmux-navigator'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

if has('nvim')
    " Lean support (https://github.com/Julian/lean.nvim/)
    Plug 'Julian/lean.nvim'
    Plug 'neovim/nvim-lspconfig'
    Plug 'nvim-lua/plenary.nvim'

    Plug 'hrsh7th/nvim-cmp'        " For LSP completion
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/vim-vsnip'       " For snippets
    Plug 'andrewradev/switch.vim'  " For Lean switch support
    Plug 'tomtom/tcomment_vim'     " For commenting motions
    Plug 'nvim-telescope/telescope.nvim' " For Loogle search
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'kosayoda/nvim-lightbulb'
    Plug 'rmagatti/goto-preview'
    Plug 'nvim-lua/lsp-status.nvim'
    Plug 'mfussenegger/nvim-dap'
endif

call plug#end()

" Install vim-plug if it's not already installed.
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.github.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Key mappings
noremap ; : " Use ; in addition to : to type commands.

" Immediately add a closing quotes or braces in insert mode.
inoremap ( ()<esc>i
inoremap { {}<esc>i
inoremap [ []<esc>i

" Exuberant Ctags settings
" Look for a tags file recursively in parent directories.
set tags=tags;
"Regenerate tags when saving Python files.
autocmd BufWritePost *.c,*.cpp,*.h,*.java,*.class,*.py silent! !ctags -R &   

colorscheme gruvbox

" FZF settings
set rtp+=/usr/local/opt/fzf

if !has('nvim')
	set nocompatible			" not compatible with Vi
	filetype plugin indent on	" mandatory for modern plugins
	syntax on				    " enable syntax highlighting
	set autoindent				" copy indent from the previous line
	set autoread				" reload from disk
	set backspace=indent,eol,start		" modern backspace behaviour
	set belloff=all				" disable the bell
	set cscopeverbose			" verbose cscope output
	set complete-=i				" don't scan current on included
						        " files for completion
    "set display=lastline,msgsep " display more message text
	set encoding=utf-8			" set default encoding
	"set fillchars=vert:|,fold:	" separator characters
	set formatoptions=tcqj		" more intuitive autoformatting
	set fsync				    " call fsync() for robust file saving
	set history=10000			" longest possible command history
	set hlsearch				" highlight search results
	set incsearch				" move cursor as you type when searching
	set langnoremap				" helps avoid mappings breaking
	set laststatus=2			" always display a status line
	set listchars=tab:>\ ,trail:-,nbsp:+	" chars for :list
	set nrformats=bin,hex		" <c-a> and <c-x> support
	set ruler				    " display current line # in a corner
	set sessionoptions-=options	" do not carry options across sessions
	set shortmess=F				" less verbose file info
	set showcmd				    " show last command in the status line
	set sidescroll=1			" smother sideways scrolling
	set smarttab				" tab setting aware <Tab> key
	set tabpagemax=50			" maximum number of tabs open by -p flag
	set tags=./tags;,tags		" filenames to look for the tag command
	set ttimeoutlen=50			" ms to wait for next key in a sequence
	set ttyfast				    " indicates that our connection is fast
	set viminfo+=!				" save global variables across sessions
	set wildmenu				" enhanced command line completion
else
    :tnoremap <Esc> <C-\><C-n>  " remap mode escape
endif

