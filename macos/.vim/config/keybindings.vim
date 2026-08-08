let mapleader = "\<space>"
let maplocalleader = ","

" Page down/up and center
noremap <c-d> <c-d>zz
noremap <c-u> <c-u>zz

" Remap terminal mode escape
tnoremap <esc> <c-\\><c-n>

noremap <leader>n :Lexplore<cr>

" VimTeX keybindings
noremap <leader>wc <cmd>VimtexCountWords<cr>
noremap <leader>ll <cmd>VimtexCompile<cr>
noremap <leader>v <plug>(vimtex-view)
