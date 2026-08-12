-- Options setup
vim.opt.number = true         -- Add line numbers to document
vim.opt.relativenumber = true -- Add relative line numbers to document
vim.opt.autoread = true       -- Automatically reload files
vim.opt.autoindent = true     -- Respect indentation when starting a new line
vim.opt.expandtab = true      -- Expand tabs to spaces. Essential in Python
vim.opt.tabstop = 4           -- Number of spaces tab is counted for
vim.opt.shiftwidth = 4        -- Number of spaces to use for autoindent
vim.opt.hlsearch = true       -- Highlight search results
vim.opt.incsearch = true      -- Show where search pattern matches
vim.opt.clipboard = "unnamed" -- Copy into system (*) register
vim.opt.ignorecase = true     -- Ignores case when searching patterns
vim.opt.smartcase = true      -- Automatically switches to case-sensitive search if a capital letter is used
vim.o.signcolumn = "yes"
vim.o.laststatus = 3          -- Use one status for all splits
vim.o.cmdheight = 0           -- Hide cmd entry when not in use
vim.opt.completeopt = { "menu", "menuone", "noinsert", "noselect", "popup" }
vim.o.autocomplete = true     -- Enable LSP autocomplete

-- Windows shell setup
-- Use cmd.exe for `!`, system(), and plugin shell-outs (e.g. vim-fugitive)
-- Use powershell.exe/pwsh.exe for terminal 
if vim.fn.has("win32") == 1 then
    vim.opt.shell = "cmd.exe"
    vim.opt.shellcmdflag = "/s /c"
    vim.opt.shellxquote = '"'
    vim.opt.shellquote = ""
    vim.opt.shellredir = ">%s 2>&1"
    vim.opt.shellpipe = "2>&1| tee"

    -- Route bare `:terminal` (and `:term`) through pwsh while leaving
    -- `:terminal <cmd>` alone so explicit invocations still hit &shell.
    local pwsh = vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell"
    vim.keymap.set("c", "<CR>", function()
        if vim.fn.getcmdtype() == ":" then
            local line = vim.fn.getcmdline()
            if line == "terminal" or line == "term" then
                return string.format("<C-u>terminal %s<CR>", pwsh)
            end
        end
        return "<CR>"
    end, { expr = true, desc = "Route bare :terminal through pwsh" })
end

-- Set tabs/spaces for different file types
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "c", "cpp", "javascript", "typescript" },
    callback = function()
        vim.opt_local.tabstop = 2
        vim.opt_local.shiftwidth = 2
    end
})
