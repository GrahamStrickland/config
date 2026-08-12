-- Adapted for Windows from
-- https://toddknutson.bio/posts/how-to-enable-neovim-undo-backup-and-swap-files-when-switching-linux-groups/
-- Kept under stdpath("state") (%LOCALAPPDATA%\nvim-data) so a fresh machine needs
-- no setup and no user/host name is baked into the config.
local STATE = vim.fn.stdpath("state")

SWAPDIR = STATE .. "/swap//"
BACKUPDIR = STATE .. "/backup//"
UNDODIR = STATE .. "/undo//"

if vim.fn.isdirectory(SWAPDIR) == 0 then
    vim.fn.mkdir(SWAPDIR, "p", "0o700")
end

if vim.fn.isdirectory(BACKUPDIR) == 0 then
    vim.fn.mkdir(BACKUPDIR, "p", "0o700")
end

if vim.fn.isdirectory(UNDODIR) == 0 then
    vim.fn.mkdir(UNDODIR, "p", "0o700")
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
