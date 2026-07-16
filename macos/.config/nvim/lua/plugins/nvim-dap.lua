-- DAP ADAPTER SETUP
local dap = require("dap")

dap.adapters.lldb = {
    type = "executable",
    command = "/opt/homebrew/opt/llvm/bin/lldb-dap",
    name = "lldb",
}

-- Python setup
local get_python_path = function()
    local venv = os.getenv("VIRTUAL_ENV")
    if venv then
        return venv .. "/bin/python3"
    end
    local cwd = vim.fn.getcwd()
    if vim.fn.executable(cwd .. "/.venv/bin/python3") == 1 then
        return cwd .. "/.venv/bin/python3"
    elseif vim.fn.executable(cwd .. "/../.venv/bin/python3") == 1 then
        return cwd .. "/../.venv/bin/python3"
    else
        return "python3"
    end
end
local dap_python = require("dap-python")

-- DAP ADAPTER CONFIGURATION
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

-- Java
-- The `java` adapter is registered per-buffer by require("jdtls").setup_dap()
-- in ftplugin/java.lua.
dap.configurations.java = {
    {
        type = "java",
        request = "launch",
        name = "Java: launch current main class",
    },
}

-- C#
require("netcoredbg-macOS-arm64").setup(dap)

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
        name = "Python: launch module",
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
        name = "Python: attach to remote",
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
