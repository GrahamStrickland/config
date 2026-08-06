-- For easy-dotnet
vim.env.DOTNET_ROOT = "/opt/homebrew/opt/dotnet/libexec"
vim.env.PATH = vim.env.PATH .. ":/Users/graham/.local/bin/roslyn/content/LanguageServer/osx-arm64"

-- Options setup
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
vim.opt.ignorecase = true     -- Ignores case when searching patterns
vim.opt.smartcase = true      -- Automatically switches to case-sensitive search if a capital letter is used
vim.o.signcolumn = "yes"
vim.o.laststatus = 3
vim.o.cmdheight = 0
vim.opt.completeopt = { "menu", "menuone", "noinsert", "noselect", "popup" }
vim.o.autocomplete = true

-- Adapted for MacOS from
-- https://toddknutson.bio/posts/how-to-enable-neovim-undo-backup-and-swap-files-when-switching-linux-groups/
USER = os.getenv("USER")
SWAPDIR = "/Users/" .. USER .. "/nvim/swap//"
BACKUPDIR = "/Users/" .. USER .. "/nvim/backup//"
UNDODIR = "/Users/" .. USER .. "/nvim/undo//"

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
