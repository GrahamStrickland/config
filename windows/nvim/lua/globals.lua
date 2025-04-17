-- OPTION SETUP --
vim.g.NERDTreeHijackNetrw = 0

vim.opt.number = true           -- Add line numbers to document.
vim.opt.relativenumber = true   -- Add relative line numbers to document.
vim.opt.autoread = true         -- Automatically reload files.
vim.opt.autoindent = true	    -- Respect indentation when starting a new line.
vim.opt.expandtab = true		-- Expand tabs to spaces. Essential in Python.
vim.opt.tabstop = 4			    -- Number of spaces tab is counted for.
vim.opt.shiftwidth = 4		    -- Number of spaces to use for autoindent.
vim.opt.background = "dark"     -- Set to dark mode.
vim.opt.hlsearch = true         -- Highlight search results.
vim.opt.incsearch = true        -- Show where search pattern matches.
vim.opt.clipboard = "unnamed"   -- Copy into system (*) register.

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

-- FURTHER SETUP --
vim.cmd("colorscheme vscode")

require("lualine").setup({
    options = {
        icons_enabled = false,
        theme = "vscode",
        section_separators = { left = '', right = '' },
        component_separators = { left = '|', right = '|' }
    },
})

require("tiny-code-action").setup()

require("goto-preview").setup({})

require("csvview").setup()

require("pqf").setup()

require("git-conflict").setup()
