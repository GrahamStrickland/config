set nocompatible			" not compatible with Vi
syntax on			        " Enable syntax highlighting.
filetype plugin indent on	" Enable file type based indentation.

set number              " Add line numbers to document.
set relativenumber      " Add relative line numbers to document.
set autoread            " Automatically reload files.
set autoindent			" Respect indentation when starting a new line.
set expandtab			" Expand tabs to spaces. Essential in Python.
set tabstop=4			" Number of spaces tab is counted for.
set shiftwidth=4		" Number of spaces to use for autoindent.
set hlsearch            " Highlight search results
set incsearch           " Show where search pattern matches
set clipboard=unnamed   " Copy into system (*) register.
set backspace=indent,eol,start  " Modern backspace behaviour
set belloff=all		    " Disable the bell
set foldmethod=indent
set wildmenu            " Enable enhanced tab autocomplete
set wildmode=list:longest,full  " Complete till longest string, then open the wildmenu
set cscopeverbose		" Verbose cscope output
set complete-=i			" Don't scan current on included files for completion
set encoding=utf-8		" Set default encoding
set formatoptions=tcqj	" More intuitive autoformatting
set fsync				" Call fsync() for robust file saving
set history=10000	    " Longest possible command history
set langnoremap			" Helps avoid mappings breaking
set laststatus=3		" Use one status for all splits 
set listchars=tab:>\ ,trail:-,nbsp:+    " Chars for :list
set nrformats=bin,hex	" <c-a> and <c-x> support
set ruler				" Display current line # in a corner
set sessionoptions-=options	" Do not carry options across sessions
set shortmess=F		    " Less verbose file info
set showcmd				" Show last command in the status line
set sidescroll=1	    " Smother sideways scrolling
set smarttab		    " Tab setting aware <Tab> key
set tabpagemax=50		" Maximum number of tabs open by -p flag
set ttimeoutlen=50		" ms to wait for next key in a sequence
set ttyfast				" Indicates that our connection is fast
set viminfo+=!			" Save global variables across sessions
set tags=tags;          " Look for a tags file recursively in parent directories.

"Regenerate tags when saving Python files.
autocmd BufWritePost *.c,*.cpp,*.h,*.java,*.class,*.py silent! !ctags -R &   
