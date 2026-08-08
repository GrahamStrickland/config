" Adapted from https://github.com/smnatale/nvim_native/blob/main/lua/grep.lua
set grepprg=rg\ --vimgrep\ --smart-case\ --hidden
set grepformat=%f:%l:%c:%m

function! s:GrepPrompt() abort
  call inputsave()
  let l:pattern = input('ripgrep: ')
  call inputrestore()
  redraw
  if empty(l:pattern)
    return
  endif
  execute 'silent grep!' fnameescape(l:pattern)
  copen
endfunction

nnoremap <silent> <leader>g :call <SID>GrepPrompt()<CR>
