-- Adapted from https://github.com/smnatale/nvim_native/blob/main/lua/statusline.lua
local pms = vim.api.nvim_get_hl(0, { name = "PmenuSel", link = false })
local dir = vim.api.nvim_get_hl(0, { name = "Directory", link = false })
local vis = vim.api.nvim_get_hl(0, { name = "Visual", link = false })
vim.api.nvim_set_hl(0, "StlMode", { fg = pms.fg, bg = vis.bg })
vim.api.nvim_set_hl(0, "StlGit", { fg = dir.fg, bg = pms.bg })

local modes = {
    n = "NORMAL",
    i = "INSERT",
    v = "VISUAL",
    V = "V-LINE",
    ["\22"] = "V-BLOCK",
    c = "COMMAND",
    t = "TERMINAL",
    R = "REPLACE",
    s = "SELECT",
    S = "S-LINE",
    ["\19"] = "S-BLOCK",
}

vim.opt.shortmess:remove("S")

vim.keymap.set(
    "n",
    "n",
    function()
        vim.cmd("normal! n")
        pcall(vim.fn.searchcount, { maxcount = 99999 })
    end
)
vim.keymap.set(
    "n",
    "N",
    function()
        vim.cmd("normal! N")
        pcall(vim.fn.searchcount, { maxcount = 99999 })
    end
)

function _G._statusline()
    local mode = modes[vim.fn.mode()] or vim.fn.mode():upper()
    local branch = vim.b.git_branch and "%#StlGit# " .. vim.b.git_branch .. " %*" or ""
    local path = vim.b.rel_path or "%f"
    local diag = ""
    local counts = vim.diagnostic.count(0) or {}
    local labels = { "E", "W", "I", "H" }
    local hls = { "DiagnosticError", "DiagnosticWarn", "DiagnosticInfo", "DiagnosticHint" }
    local modified = "%m"
    local ok, search_info = pcall(vim.fn.searchcount, { maxcount = 99999, timeout = 500 })

    local search_str = ""

    if ok and search_info and search_info.total > 0 then
        local current = search_info.current
        local total = search_info.total

        search_str = string.format(" [%d/%d]", current, total)
    end
    for i = 1, 4 do
        if counts[i] and counts[i] > 0 then
            diag = diag .. "%#" .. hls[i] .. "#" .. labels[i] .. counts[i] .. "%* "
        end
    end

    return "%#StlMode# " .. mode .. " %*" .. branch .. " " .. path .. "%=" .. diag .. vim.bo.filetype .. modified .. search_str .. " %l:%c"
end

vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
        local root = vim.fn.system("git rev-parse --show-toplevel 2>/dev/null"):gsub("%s+$", "")
        if root ~= "" then
            vim.b.git_branch = vim.fn.system("git branch --show-current 2>/dev/null"):gsub("%s+$", "")
            vim.b.rel_path = vim.fn.expand("%:p"):sub(#root + 2)
        else
            vim.b.git_branch = nil
            vim.b.rel_path = vim.fn.expand("%:p:~")
        end
    end,
})

vim.api.nvim_create_autocmd("DiagnosticChanged", {
    callback = function()
        vim.cmd("redrawstatus!")
    end,
})

vim.o.statusline = "%!v:lua._statusline()"
