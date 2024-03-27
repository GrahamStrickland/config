" Vim with all enhancements
" source $VIMRUNTIME/vimrc_example.vim

" Use the internal diff if available.
" Otherwise use the special 'diffexpr' for Windows.
if &diffopt !~# 'internal'
  set diffexpr=MyDiff()
endif
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction

set encoding=utf-8

" Set clipboard
set clipboard=unnamed
set mouse=a 

" Set undo directory to avoid swp overload
set undodir=~/.vim/.undo//
set backupdir=~/.vim/.backup//
set directory=~/.vim/.swp//

" Map the leader key to a comma.
let mapleader = "\<space>"

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

" Close buffer without closing window.
command! Bd :bp | :sp | :bn | :bd

set foldmethod=indent

" Enable enhanced tab autocomplete
set wildmenu                    
set wildmode=list:longest,full

let NERDTreeHijackNetrw = 0

nnoremap <C-b> :CtrlPBuffer<cr> " Map Ctrlp buffer mode to Ctrl + B.

set hlsearch
set incsearch

set clipboard=unnamed           " Copy into system (*) register.

" Manage plugins with vim-plug
call plug#begin()

Plug 'junegunn/vim-plug'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'vim-syntastic/syntastic'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-fugitive'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mileszs/ack.vim'
Plug 'easymotion/vim-easymotion'
Plug 'doums/darcula'
Plug 'tomasiser/vim-code-dark'
Plug 'sainnhe/everforest'
Plug 'morhetz/gruvbox'

call plug#end()

" Install vim-plug if it's not already installed
if empty(glob('C:\tools\vim\~\.vim\autoload'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.github.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

noremap ; : " Use ; in addition to : to type commands.

" Immediately add a closing quotes or braces in insert mode
inoremap ( ()<esc>i
inoremap { {}<esc>i
inoremap [ []<esc>i
"
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

set termguicolors
colorscheme gruvbox " Set color scheme.

