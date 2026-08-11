vim.keymap.set("n", "<leader>g", function()
    vim.ui.input({ prompt = "ripgrep: " }, function(pattern)
        if not pattern or pattern == "" then return end

        local cmd = { "rg", "--vimgrep", "--smart-case", "--hidden", pattern }
        local output = vim.fn.system(cmd)

        vim.fn.setqflist({}, "r", {
            title = "ripgrep: " .. pattern,
            lines = vim.split(output, "\n", { trimempty = true }),
            efm = "%f:%l:%c:%m",
        })
        vim.cmd("copen")
    end)
end, { silent = true })
