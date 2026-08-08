" Set tabs/spaces for different file types
augroup filetype_indent
  autocmd!
  autocmd FileType c,cpp,javascript,lean,objc,objcpp,r,typescript
        \ setlocal tabstop=2 shiftwidth=2
augroup END

" Append backup files with timestamp
augroup timestamped_backups
  autocmd!
  autocmd BufWritePre * let &backupext = '~' . strftime('%Y-%m-%d-%H%M%S')
augroup END
