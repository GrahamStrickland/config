 " Adapted for MacOS from
  " https://toddknutson.bio/posts/how-to-enable-neovim-undo-backup-and-swap-files-when-switching-linux-groups/
  let s:swapdir   = '/Users/' . $USER . '/vim/swap//'
  let s:backupdir = '/Users/' . $USER . '/vim/backup//'
  let s:undodir   = '/Users/' . $USER . '/vim/undo//'

  for s:dir in [s:swapdir, s:backupdir, s:undodir]
    if !isdirectory(s:dir)
      call mkdir(s:dir, 'p', 0700)
    endif
  endfor

  " Enable swap, backup, and persistent undo
  let &directory = s:swapdir
  let &backupdir = s:backupdir
  let &undodir   = s:undodir
  set swapfile
  set backup
  set undofile
