-- OPTION SETUP --
vim.g.NERDTreeHijackNetrw = 0

vim.opt.number = true         -- Add line numbers to document.
vim.opt.relativenumber = true -- Add relative line numbers to document.
vim.opt.autoread = true       -- Automatically reload files.
vim.opt.autoindent = true     -- Respect indentation when starting a new line.
vim.opt.expandtab = true      -- Expand tabs to spaces. Essential in Python.
vim.opt.tabstop = 4           -- Number of spaces tab is counted for.
vim.opt.shiftwidth = 4        -- Number of spaces to use for autoindent.
vim.opt.background = "dark"   -- Set to dark mode.
vim.opt.hlsearch = true       -- Highlight search results.
vim.opt.incsearch = true      -- Show where search pattern matches.
vim.opt.clipboard = "unnamed" -- Copy into system (*) register.

-- Adapted for Windows from
-- https://toddknutson.bio/posts/how-to-enable-neovim-undo-backup-and-swap-files-when-switching-linux-groups/
SWAPDIR = [[C:\Users\graham\AppData\Local\nvim\swap\]]
BACKUPDIR = [[C:\Users\graham\AppData\Local\nvim\backup\]]
UNDODIR = [[C:\Users\graham\AppData\Local\nvim\undo\]]

if vim.fn.isdirectory(SWAPDIR) == 0 then
    vim.fn.mkdir(SWAPDIR, "p", "0o700")
end

if vim.fn.isdirectory(BACKUPDIR) == 0 then
    vim.fn.mkdir(BACKUPDIR, "p", "0o700")
end

if vim.fn.isdirectory(UNDODIR) == 0 then
    vim.fn.mkdir(UNDODIR, "p", "0o700")
end

-- WINDOWS SHELL SETUP
if vim.fn.has("win32") == 1 then
  if vim.fn.executable("pwsh") == 1 then
    vim.opt.shell = "pwsh"
  else
    vim.opt.shell = "powershell"
  end

  vim.opt.shellcmdflag = "-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
  vim.opt.shellredir = "2>&1 | Out-File -Encoding utf8 %s; exit $LastExitCode"
  vim.opt.shellpipe = "2>&1 | Out-File -Encoding utf8 %s; exit $LastExitCode"
  vim.opt.shellquote = ""
  vim.opt.shellxquote = ""
end

-- Enable swap, backup, and persistant undo
vim.opt.directory = SWAPDIR
vim.opt.backupdir = BACKUPDIR
vim.opt.undodir = UNDODIR
vim.opt.swapfile = true
vim.opt.backup = true
vim.opt.undofile = true

-- Append backup files with timestamp
vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function()
        local extension = "~" .. vim.fn.strftime("%Y-%m-%d-%H%M%S")
        vim.o.backupext = extension
    end,
})

-- UI SETUP --
vim.o.background = "dark"
vim.cmd("colorscheme kanso-zen")
vim.o.winborder = "rounded"
