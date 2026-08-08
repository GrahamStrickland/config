" Adapted from https://github.com/smnatale/nvim_native/blob/main/lua/find.lua
let s:ignore_patterns = [
      \ 'node_modules',
      \ '\.git',
      \ '\.cache',
      \ 'dist',
      \ 'build',
      \ '\.tmp',
      \ '\.log',
      \ '__pycache__',
      \ '.venv',
      \ ]

function! NativeFind(cmdarg, cmdcomplete) abort
  let l:result = []
  for l:f in glob('**/*', 1, 1)
    if isdirectory(l:f)
      continue
    endif
    let l:skip = 0
    for l:pat in s:ignore_patterns
      if l:f =~# l:pat
        let l:skip = 1
        break
      endif
    endfor
    if !l:skip
      call add(l:result, l:f)
    endif
  endfor
  return matchfuzzy(l:result, a:cmdarg)
endfunction

if exists('+findfunc')
  set findfunc=NativeFind
endif

nnoremap <leader>f :find<space>
