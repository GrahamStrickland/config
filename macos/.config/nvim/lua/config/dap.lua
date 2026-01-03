-- DAP ADAPTER SETUP
local dap = require("dap")

-- CodeLLDB setup
local function find_codelldb_executable()
    local files = vim.fn.glob("/Users/graham/.vscode/extensions/vadimcn.vscode-lldb-*/adapter/codelldb", true, true)

    if #files == 0 then
        return "codelldb"
    end

    for _, file in ipairs(files) do
        if file:match("/Users/graham/.vscode/extensions/vadimcn.vscode-lldb-$") then
            return file
        end
    end

    return files[1]
end

dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
        command = find_codelldb_executable(),
        args = { "--port", "${port}" },
    }
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

-- UI setup
require("dapui").setup()

-- DAP ADAPTER CONFIGURATION
-- C++
dap.configurations.cpp = {
    {
        name = "C++: launch process",
        type = "codelldb",
        request = "launch",
        program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd(), "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        showDisassembly = "never",
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

-- Rust
dap.configurations.rust = {
    {
        name = "Rust: launch process",
        type = "codelldb",
        request = "launch",
        program = function()
            vim.fn.system("cargo build")
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        showDisassembly = "never",
    },
}
