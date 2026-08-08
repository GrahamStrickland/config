-- DAP adapter setup
local dap = require("dap")

dap.adapters.gdb = {
    type = "executable",
    command = "gdb",
    args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
}

dap.adapters.rust_gdb = {
    type = "executable",
    command = vim.fn.executable("rust-gdb") == 1 and "rust-gdb" or "gdb",
    args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
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

-- DAP configuration
-- C
dap.configurations.c = {
    {
        name = "C: launch process",
        type = "gdb",
        request = "launch",
        program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopAtBeginningOfMainSubprogram = false,
    },
    {
        name = "C: launch process with arguments",
        type = "gdb",
        request = "launch",
        program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        args = function()
            local args_string = vim.fn.input("Arguments: ")
            return vim.split(args_string, " ")
        end,
        cwd = "${workspaceFolder}",
        stopAtBeginningOfMainSubprogram = false,
    },
    {
        name = "C: attach to process",
        type = "gdb",
        request = "attach",
        pid = function()
            return tonumber(vim.fn.input("PID: "))
        end,
        cwd = "${workspaceFolder}",
    },
}

-- C++
dap.configurations.cpp = dap.configurations.c

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
        type = "rust_gdb",
        request = "launch",
        program = function()
            vim.fn.system("cargo build")
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopAtBeginningOfMainSubprogram = false,
    },
    {
        name = "Rust: launch process with arguments",
        type = "rust_gdb",
        request = "launch",
        program = function()
            vim.fn.system("cargo build")
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
        end,
        args = function()
            local args_string = vim.fn.input("Arguments: ")
            return vim.split(args_string, " ")
        end,
        cwd = "${workspaceFolder}",
        stopAtBeginningOfMainSubprogram = false,
    },
}
