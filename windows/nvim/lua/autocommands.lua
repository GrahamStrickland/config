-- Ensures the menu appears even for a single match and uses the native popup window
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp_completion", { clear = true }),
    callback = function(args)
        local client_id = args.data.client_id
        if not client_id then
            return
        end

        local client = vim.lsp.get_client_by_id(client_id)
        if client and client:supports_method("textDocument/completion") then
            -- Enable native LSP completion for this client + buffer
            vim.lsp.completion.enable(true, client_id, args.buf, {
                autotrigger = true, -- auto-show menu as you type (recommended)
                -- You can also set { autotrigger = false } and trigger manually with <C-x><C-o>
            })
        end
    end,
})

-- Disable native autocomplete in special buffers (e.g. Telescope's prompt).
vim.api.nvim_create_autocmd({ "BufNew", "BufEnter", "FileType" }, {
    callback = function(args)
        vim.bo[args.buf].autocomplete = vim.bo[args.buf].buftype == ""
    end,
})

-- Set tabs/spaces for different file types
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "c", "cpp", "javascript", "lean", "objc", "objcpp", "r", "typescript" },
    callback = function()
        vim.opt_local.tabstop = 2
        vim.opt_local.shiftwidth = 2
    end
})

-- Append backup files with timestamp
vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function()
        local extension = "~" .. vim.fn.strftime("%Y-%m-%d-%H%M%S")
        vim.o.backupext = extension
    end,
})
