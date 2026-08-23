vim.env.HARBOUR_DBG_TRACE = "1"

-- DAP adapter setup
local dap = require("dap")

-- Signs and highlights
local set_dap_highlights = function()
    vim.api.nvim_set_hl(0, "DapStoppedLine", { bg = "#5f5f00", ctermbg = 58 })
    vim.api.nvim_set_hl(0, "DapStoppedSign", { fg = "#ffaf00", ctermfg = 214, bold = true })
    vim.api.nvim_set_hl(0, "DapBreakpointSign", { fg = "#ff5f5f", ctermfg = 203, bold = true })
    vim.api.nvim_set_hl(0, "DapLogPointSign", { fg = "#87afaf", ctermfg = 109, bold = true })
    vim.api.nvim_set_hl(0, "DapBreakpointRejectedSign", { fg = "#949494", ctermfg = 246 })
end

set_dap_highlights()
vim.api.nvim_create_autocmd("ColorScheme", { callback = set_dap_highlights })

vim.fn.sign_define("DapBreakpoint",
    { text = "●", texthl = "DapBreakpointSign", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointCondition",
    { text = "◆", texthl = "DapBreakpointSign", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointRejected",
    { text = "○", texthl = "DapBreakpointRejectedSign", linehl = "", numhl = "" })
vim.fn.sign_define("DapLogPoint",
    { text = "◆", texthl = "DapLogPointSign", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped",
    { text = "→", texthl = "DapStoppedSign", linehl = "DapStoppedLine", numhl = "DapStoppedSign" })

dap.adapters.lldb = {
    type = "executable",
    command = "C:/Program Files/LLVM/bin/lldb-dap.exe",
    name = "lldb",
}

-- Python setup
local get_python_path = function()
    local venv = os.getenv("VIRTUAL_ENV")
    if venv then
        return venv .. "\\Scripts\\python.exe"
    end

    local cwd = vim.fn.getcwd()
    if vim.fn.executable(cwd .. "\\.venv\\Scripts\\python.exe") == 1 then
        return cwd .. "\\.venv\\Scripts\\python.exe"
    end

    return "py.exe"
end
local dap_python = require("dap-python")

-- DAP adapter configuration
-- C
dap.configurations.c = {
    {
        name = "C: launch process",
        type = "lldb",
        request = "launch",
        program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd(), "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        showDisassembly = "never",
    },
    {
        name = "C: launch process with arguments",
        type = "lldb",
        request = "launch",
        program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd(), "file")
        end,
        args = function()
            local args_string = vim.fn.input("Arguments: ")
            return vim.split(args_string, " ")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        showDisassembly = "never",
    },
}

-- C++
dap.configurations.cpp = {
    {
        name = "C++: launch process",
        type = "lldb",
        request = "launch",
        program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd(), "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        showDisassembly = "never",
    },
    {
        name = "C++: launch process with arguments",
        type = "lldb",
        request = "launch",
        program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd(), "file")
        end,
        args = function()
            local args_string = vim.fn.input("Arguments: ")
            return vim.split(args_string, " ")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        showDisassembly = "never",
    },
}

local function vsdbg_path()
    local standalone = vim.fs.joinpath(vim.fn.stdpath("data"), "vsdbg", "vsdbg.exe")
    if vim.fn.executable(standalone) == 1 then
        return standalone
    end
    local pattern = "~/.vscode/extensions/ms-vscode.cpptools-*/debugAdapters/vsdbg/bin/vsdbg.exe"
    local found = vim.fn.glob(vim.fn.expand(pattern), true, true)
    return found[#found] or standalone
end

dap.adapters.cppvsdbg = {
    type = "executable",
    command = vsdbg_path(),
    args = { "--interpreter=vscode" },
}

local vsdbg_configurations = {
    {
        name = "C/C++: launch process (MSVC)",
        type = "cppvsdbg",
        request = "launch",
        program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "\\", "file")
        end,
        cwd = "${workspaceFolder}",
        stopAtEntry = false,
        console = "integratedTerminal",
    },
    {
        name = "C/C++: launch process with arguments (MSVC)",
        type = "cppvsdbg",
        request = "launch",
        program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "\\", "file")
        end,
        args = function()
            local args_string = vim.fn.input("Arguments: ")
            return vim.split(args_string, " ")
        end,
        cwd = "${workspaceFolder}",
        stopAtEntry = false,
        console = "integratedTerminal",
    },
}

for i = #vsdbg_configurations, 1, -1 do
    table.insert(dap.configurations.c, 1, vsdbg_configurations[i])
    table.insert(dap.configurations.cpp, 1, vsdbg_configurations[i])
end

-- C#
dap.adapters.coreclr = {
    type = "executable",
    command = vim.fs.joinpath(vim.fn.stdpath("data"), "netcoredbg", "netcoredbg.exe"),
    args = { "--interpreter=vscode" },
}

dap.configurations.cs = {
    {
        name = "C#: launch process",
        type = "coreclr",
        request = "launch",
        cwd = "${workspaceFolder}",
        program = function()
            return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/bin/Debug/", "file")
        end,
    },
}

-- Harbour
dap.adapters["harbour-dbg"] = {
    type = "executable",
    command = "node",
    args = { "C:/Users/graham/dev/harbourCodeExtension/client/dist/debugger.js" },
}

-- Default configs (used when no .vscode/launch.json is present)
dap.configurations.clipper = {
    {
        type = "harbour-dbg",
        request = "launch",
        name = "Launch Harbour program",
        program = "${workspaceFolder}/Program",
        workingDir = "${workspaceFolder}/",
        sourcePaths = { "${workspaceFolder}" },
        stopOnEntry = false,
        terminalType = "none",
    },
}

-- Python
dap_python.setup(get_python_path())
dap_python.test_runner = "pytest"
dap.configurations.python = {
    {
        type = "debugpy",
        request = "launch",
        name = "Python: launch file",
        justMyCode = false,
        cwd = vim.fn.getcwd(),
        program = "${file}",
        console = "integratedTerminal",
        pythonPath = get_python_path(),
    },
    {
        type = "debugpy",
        request = "launch",
        name = "Python: launch Module",
        justMyCode = false,
        module = function()
            return vim.fn.input("Module name: ")
        end,
        console = "integratedTerminal",
        pythonPath = get_python_path(),
    },
    {
        type = "debugpy",
        request = "attach",
        name = "Python: attach remote",
        justMyCode = false,
        pythonPath = get_python_path(),
        host = function()
            local value = vim.fn.input("Host [127.0.0.1]: ")
            if value ~= "" then
                return value
            end
            return "127.0.0.1"
        end,
        port = function()
            return tonumber(vim.fn.input("Port [5678]: ")) or 5678
        end,
    },
}
