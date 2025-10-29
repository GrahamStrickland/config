-- DAP ADAPTER SETUP/CONFIGURATION
local get_python_path = function()
    local venv = os.getenv("VIRTUAL_ENV") 
    if venv == nil then
        return "py.exe"
    end
    return venv .. "/bin/python3"
end
local dap_python = require("dap-python")

-- UI setup
require("dapui").setup()

local dap = require("dap")
-- Python
dap_python.setup(get_python_path())
dap_python.setup("uv")
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
dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
        command = "/Users/graham/.vscode/extensions/vadimcn.vscode-lldb-1.11.8/adapter/codelldb",
        args = {"--port", "${port}"},
    }
}
dap.configurations.rust = {
    {
        name = "Rust: launch process",
        type = "codelldb",
        request = "launch",
        program = function()
            vim.fn.jobstart("cargo build")
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = true,
        showDisassembly = "never",
    },
}
