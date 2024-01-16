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
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mileszs/ack.vim'
Plug 'easymotion/vim-easymotion'
Plug 'junegunn/vim-plug'
Plug 'doums/darcula'
Plug 'tomasiser/vim-code-dark'
Plug 'morhetz/gruvbox'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'christoomey/vim-tmux-navigator'

let g:plug_timeout = 300    " Increase vim-plug timeout for YouCompleteMe.
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }

call plug#end()

" Install vim-plug if it's not already installed.
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.github.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Key mappings
noremap ; : " Use ; in addition to : to type commands.

" Immediately add a closing quotes or braces in insert mode.
inoremap ( ()<esc>i
inoremap { {}<esc>i
inoremap [ []<esc>i

" YouCompleteMe settings
noremap <leader>] :YcmCompleter GoTo<cr>

" Exuberant Ctags settings
" Look for a tags file recursively in parent directories.
set tags=tags;
"Regenerate tags when saving Python files.
autocmd BufWritePost *.c,*.cpp,*.h,*.java,*.class,*.py silent! !ctags -R &   

colorscheme gruvbox

