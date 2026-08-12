-- Options setup
vim.opt.number = true             -- Add line numbers to document
vim.opt.relativenumber = true     -- Add relative line numbers to document
vim.opt.autoread = true           -- Automatically reload files
vim.opt.autoindent = true         -- Respect indentation when starting a new line
vim.opt.expandtab = true          -- Expand tabs to spaces. Essential in Python
vim.opt.tabstop = 4               -- Number of spaces tab is counted for
vim.opt.shiftwidth = 4            -- Number of spaces to use for autoindent
vim.opt.hlsearch = true           -- Highlight search results
vim.opt.incsearch = true          -- Show where search pattern matches
vim.opt.clipboard = "unnamedplus" -- Copy into system (+) register
vim.opt.ignorecase = true         -- Ignores case when searching patterns
vim.opt.smartcase = true          -- Automatically switches to case-sensitive search if a capital letter is used
vim.o.signcolumn = "yes"
vim.o.laststatus = 3              -- Use one status for all splits
vim.o.cmdheight = 0               -- Hide cmd entry when not in use
vim.opt.completeopt = { "menu", "menuone", "noinsert", "noselect", "popup" }
vim.o.autocomplete = true         -- Enable LSP autocomplete

-- Treesitter highlighting, replacing the old nvim-treesitter.configs setup.
vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("treesitter_start", { clear = true }),
    callback = function(args)
        pcall(vim.treesitter.start, args.buf)
    end,
})

-- Set tabs/spaces for different file types
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "c", "cpp", "javascript", "r", "typescript" },
    callback = function()
        vim.opt_local.tabstop = 2
        vim.opt_local.shiftwidth = 2
    end
})
