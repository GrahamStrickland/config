" Map the leader key to a comma.
let mapleader = "\<space>"

" Save a file with leader-w.
noremap <leader>w :w<cr>

noremap <leader>n : NERDTreeToggle<cr>

syntax on			        " Enable syntax highlighting.
filetype plugin indent on	" Enable file type based indentation.

set number              " Add line numbers to document.
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
Plug 'vim-syntastic/syntastic'
Plug 'doums/darcula'
Plug 'tomasiser/vim-code-dark'
Plug 'morhetz/gruvbox'
Plug 'sainnhe/everforest'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

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

" YCM settings - see https://dane-bulat.medium.com/vim-setting-up-a-build-system-and-code-completion-for-c-and-c-eb263c0a19a1 
" Mapping to close the completion menu (default <C-y>)
let g:ycm_key_list_stop_completion = ['<C-x>']

" Set filetypes where YCM will be turned on
let g:ycm_filetype_whitelist = { 'cpp':1, 'h':2, 'hpp':3, 'c':4, 'cxx':5 }

" Close preview window after completing the insertion
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1

let g:ycm_confirm_extra_conf = 0                 " Don't confirm python conf
let g:ycm_always_populate_location_list = 1      " Always populae diagnostics list
let g:ycm_enable_diagnostic_signs = 1            " Enable line highligting diagnostics
let g:ycm_open_loclist_on_ycm_diags = 1          " Open location list to view diagnostics

let g:ycm_max_num_candidates = 20                " Max number of completion suggestions
let g:ycm_max_num_identifier_candidates = 10     " Max number of identifier-based suggestions
let g:ycm_auto_trigger = 1                       " Enable completion menu
let g:ycm_show_diagnostic_ui = 1                 " Show diagnostic display features
let g:ycm_error_symbol = '>>'                    " The error symbol in Vim gutter
let g:ycm_enable_diagnostic_signs = 1            " Display icons in Vim's gutter, error, warnings
let g:ycm_enable_diagnostic_highlighting = 1     " Highlight regions of diagnostic text
let g:ycm_echo_current_diagnostic = 1            " Echo line's diagnostic that cursor is on

" Linting settings for make
autocmd filetype python setlocal makeprg=pylint\ --reports=n\ --msg-template=\"{path}:{line}:\ {msg_id}\ {symbol},\ {obj}\ {msg}\"\ %:p
autocmd filetype python setlocal errorformat=%f:%l:\ %m

" Syntastic recommended settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

colorscheme everforest  " Set color scheme.

