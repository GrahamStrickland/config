-- Harbour compiler-backed diagnostics for Neovim.
-- Mirrors harbourCodeExtension/client/src/validation.js: spawns the Harbour
-- compiler on open/save, parses stderr, and publishes vim.diagnostic entries.

local M = {}

-- With -s -q0 -m -n0 it performs a pure syntax/semantic check and emits
-- "file(line) Error/Warning msg" lines that validation.js parses.
local config = {
    compilerExecutable = [[C:\Users\graham\dev\harbour-3.2.0core\bin\win\msvc\harbour.exe]],
    warningLevel = 3,
    extraIncludePaths = {
        [[C:\Users\graham\dev\harbour-3.2.0dev\include]],
        [[C:\Users\graham\dev\hwgui-2.23-b2\include]],
        [[C:\Users\graham\dev\harbour-3.2.0dev\contrib\hbfimage]],
        [[C:\Users\graham\dev\harbour-3.2.0dev\contrib\hbhpdf]],
        [[C:\Users\graham\dev\harbour-3.2.0dev\contrib\hbzebra]],
        [[C:\Users\graham\dev\harbour-3.2.0dev\contrib\hbcurl]],
        [[C:\Users\graham\dev\harbour-3.2.0dev\contrib\hbwin]],
        [[C:\Users\graham\dev\harbour-3.2.0dev\contrib\hbsqlit3]],
        [[C:\Users\graham\dev\easipos-8.0\EasiPosX\include]]
    },
    extraOptions = "",
    validating = true,
}

local ns = vim.api.nvim_create_namespace("harbour")

-- Lua patterns don't support alternation, so match severity as any word
-- and filter via severity_of().
local val_pattern_any = "^([^(]*)%((%d+)%)%s+(%a+)%s+(.-)%s*$"

local function severity_of(word)
    if word == "Warning" then return vim.diagnostic.severity.WARN end
    if word == "Error" then return vim.diagnostic.severity.ERROR end
    return nil
end

local function norm(p)
    return (p:gsub("\\", "/")):lower()
end

local function parse_line(line, bufname_norm, diags, done)
    local file, lnum_s, sev_word, msg = line:match(val_pattern_any)
    local lnum
    if file then
        lnum = tonumber(lnum_s) - 1
    else
        -- Some messages have no "file(line)" prefix; skip — nothing to attach.
        return
    end
    local sev = severity_of(sev_word)
    if not sev then return end

    -- Only publish diagnostics for the current buffer's file.
    if file ~= "" and norm(file) ~= bufname_norm then
        return
    end

    -- Extract 'subject' tokens quoted with single quotes.
    local subjects = {}
    for s in msg:gmatch("'([^']+)'") do
        table.insert(subjects, s)
    end

    -- Mirror JS: if a second subject contains "(N)", treat N as the true line.
    if #subjects > 1 and subjects[2]:find("%(") then
        local n = subjects[2]:match("%((%d+)%)")
        if n then lnum = tonumber(n) - 1 end
    end

    local key_subject = subjects[1]
    if key_subject then
        done[lnum] = done[lnum] or {}
        if done[lnum][key_subject] then return end
        done[lnum][key_subject] = true
    end

    local placed = false
    if key_subject then
        local line_text = vim.api.nvim_buf_get_lines(done.__bufnr, lnum, lnum + 1, false)[1] or ""
        local escaped = key_subject:gsub("(%W)", "%%%1")
        local start_idx = 1
        while true do
            local s, e = line_text:find(escaped, start_idx)
            if not s then break end
            -- word boundary check
            local before = s == 1 or not line_text:sub(s - 1, s - 1):match("[%w_]")
            local after = e == #line_text or not line_text:sub(e + 1, e + 1):match("[%w_]")
            if before and after then
                table.insert(diags, {
                    lnum = lnum,
                    col = s - 1,
                    end_lnum = lnum,
                    end_col = e,
                    severity = sev,
                    message = msg,
                    source = "clipper",
                })
                placed = true
            end
            start_idx = e + 1
        end
    end
    if not placed then
        table.insert(diags, {
            lnum = lnum,
            col = 0,
            end_lnum = lnum,
            end_col = 0,
            severity = sev,
            message = msg,
            source = "clipper",
        })
    end
end

function M.validate(bufnr)
    if not config.validating then return end
    bufnr = bufnr or vim.api.nvim_get_current_buf()
    if not vim.api.nvim_buf_is_valid(bufnr) then return end

    local fname = vim.api.nvim_buf_get_name(bufnr)
    if fname == "" then return end

    local ext = fname:match("%.([^.]+)$")
    if not ext then return end
    ext = ext:lower()
    if ext ~= "prg" and ext ~= "ch" then return end

    local cwd = vim.fn.fnamemodify(fname, ":h")
    -- harbour.exe flags (match validation.js):
    --   -s         : syntax check only, no output files
    --   -q0        : suppress copyright/info banner
    --   -m         : compile this module only (don't chase AUTOMATIC includes)
    --   -n0        : no implicit main function
    --   -w<level>  : warning level
    local args = { "-s", "-q0", "-m", "-n0", "-w" .. tostring(config.warningLevel), fname }
    for _, p in ipairs(config.extraIncludePaths) do
        p = p:gsub("%${workspaceFolder}", cwd)
        table.insert(args, "-I" .. p)
    end
    if config.extraOptions ~= "" then
        for tok in config.extraOptions:gmatch("%S+") do
            table.insert(args, tok)
        end
    end

    local bufname_norm = norm(fname)
    local diags = {}
    local done = { __bufnr = bufnr }

    local cmd = { config.compilerExecutable }
    for _, a in ipairs(args) do table.insert(cmd, a) end

    local ok, err = pcall(vim.system, cmd, { cwd = cwd, text = true }, function(obj)
        local stderr = obj.stderr or ""
        vim.schedule(function()
            if not vim.api.nvim_buf_is_valid(bufnr) then return end
            for line in stderr:gmatch("[^\r\n]+") do
                parse_line(line, bufname_norm, diags, done)
            end
            vim.diagnostic.set(ns, bufnr, diags)
        end)
    end)
    if not ok then
        vim.schedule(function()
            vim.notify("harbour compiler '" .. config.compilerExecutable .. "' not runnable: " ..
                tostring(err), vim.log.levels.WARN)
        end)
    end
end

function M.clear(bufnr)
    bufnr = bufnr or vim.api.nvim_get_current_buf()
    if vim.api.nvim_buf_is_valid(bufnr) then
        vim.diagnostic.set(ns, bufnr, {})
    end
end

function M.setup(opts)
    if opts then config = vim.tbl_extend("force", config, opts) end

    local group = vim.api.nvim_create_augroup("HarbourValidate", { clear = true })
    vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost" }, {
        group = group,
        pattern = { "*.prg", "*.ch" },
        callback = function(ev) M.validate(ev.buf) end,
    })
    vim.api.nvim_create_autocmd("BufDelete", {
        group = group,
        pattern = { "*.prg", "*.ch" },
        callback = function(ev) M.clear(ev.buf) end,
    })
end

M.setup()
return M
