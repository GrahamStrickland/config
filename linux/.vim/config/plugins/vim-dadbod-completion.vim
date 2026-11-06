augroup dadbod_completion
  autocmd!
  autocmd FileType sql,mysql,plsql setlocal omnifunc=vim_dadbod_completion#omni
augroup END
