" Adapted from https://github.com/smnatale/nvim_native/blob/main/lua/statusline.lua

function! s:Attr(group, what, mode) abort
  return synIDattr(synIDtrans(hlID(a:group)), a:what, a:mode)
endfunction

function! s:DeriveHl(target, fg_src, bg_src) abort
  let l:args = []
  for [l:key, l:mode, l:opt] in [
        \ ['fg#', 'gui',   'guifg'],
        \ ['bg#', 'gui',   'guibg'],
        \ ['fg',  'cterm', 'ctermfg'],
        \ ['bg',  'cterm', 'ctermbg'],
        \ ]
    let l:src = l:key[0:1] ==# 'fg' ? a:fg_src : a:bg_src
    let l:val = s:Attr(l:src, l:key, l:mode)
    if !empty(l:val)
      call add(l:args, l:opt . '=' . l:val)
    endif
  endfor
  execute 'highlight clear' a:target
  if !empty(l:args)
    execute 'highlight' a:target join(l:args)
  endif
endfunction

function! s:SetStatuslineHl() abort
  call s:DeriveHl('StlMode', 'PmenuSel', 'Visual')
  call s:DeriveHl('StlGit', 'Directory', 'PmenuSel')
endfunction

call s:SetStatuslineHl()

let s:modes = {
      \ 'n':       'NORMAL',
      \ 'i':       'INSERT',
      \ 'v':       'VISUAL',
      \ 'V':       'V-LINE',
      \ "\<C-v>":  'V-BLOCK',
      \ 'c':       'COMMAND',
      \ 't':       'TERMINAL',
      \ 'R':       'REPLACE',
      \ 's':       'SELECT',
      \ 'S':       'S-LINE',
      \ "\<C-s>":  'S-BLOCK',
      \ }

set shortmess-=S              " Show the search count message.

function! Statusline() abort
  let l:mode = get(s:modes, mode(), toupper(mode()))

  let l:branch = empty(get(b:, 'git_branch', ''))
        \ ? ''
        \ : '%#StlGit# ' . b:git_branch . ' %*'
  let l:path = get(b:, 'rel_path', '%f')

  let l:diag = ''

  let l:search = ''
  if exists('*searchcount')
    try
      let l:info = searchcount({'maxcount': 99999, 'timeout': 500})
      if get(l:info, 'total', 0) > 0
        let l:search = printf(' [%d/%d]', l:info.current, l:info.total)
      endif
    catch
    endtry
  endif

  return '%#StlMode# ' . l:mode . ' %*' . l:branch . ' ' . l:path
        \ . '%=' . l:diag . &filetype . '%m' . l:search . ' %l:%c'
endfunction

function! s:UpdateGitInfo() abort
  let l:root = trim(system('git rev-parse --show-toplevel 2>/dev/null'))
  if !empty(l:root)
    let b:git_branch = trim(system('git branch --show-current 2>/dev/null'))
    let b:rel_path = strpart(expand('%:p'), strlen(l:root) + 1)
  else
    unlet! b:git_branch
    let b:rel_path = expand('%:p:~')
  endif
endfunction

augroup statusline
  autocmd!
  autocmd BufEnter * call s:UpdateGitInfo()
  autocmd ColorScheme * call s:SetStatuslineHl()
  if exists('##DiagnosticChanged')
    autocmd DiagnosticChanged * redrawstatus!
  endif
augroup END

set laststatus=2
let &statusline = '%!Statusline()'
