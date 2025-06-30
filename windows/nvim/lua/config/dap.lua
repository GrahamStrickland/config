-- DAP ADAPTER SETUP/CONFIGURATION
local get_python_path = function()
    local venv = os.getenv("VIRTUAL_ENV") 
    if venv == nil then
        return "py.exe"
    end
    return venv .. "\\Scripts\\python.exe"
end
local dap_python = require("dap-python")
dap_python.setup(get_python_path())

-- UI setup
require("neodev").setup({
    library = { plugins = { "nvim-dap-ui" }, types = true },
})
require("dapui").setup()

-- Python
dap_python.setup(get_python_path())
dap_python.setup("uv")
dap_python.test_runner = "pytest"

local dap = require("dap")
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
