-- DAP ADAPTER SETUP/CONFIGURATION
-- UI setup
require("neodev").setup({
  library = { plugins = { "nvim-dap-ui" }, types = true },
})
require("dapui").setup()

-- debugpy setup/configuration
local dap = require("dap")
dap.adapters.python = {
    type = "executable";
    command = os.getenv("UserProfile") .. "\\dev\\easipos\\EasiQTX\\.venv\\Scripts\\python.exe";
    args = { "-m", "python.adapter" };
}
dap.configurations.python = {
    {
        type = "python";
        request = "launch";
        name = "Run hbxsharpconvert";
        program = os.getenv("UserProfile") .. "\\dev\\hbxsharpconvert\\hbxsharpconvert.py";
        pythonPath = function()
            return os.getenv("UserProfile") .. "\\dev\\hbxsharpconvert\\.venv\\Scripts\\python.exe"
        end,
        args = {
            "--input=..\\easipos\\EasiPOSX\\easiutil\\adt.prg", 
            "--output=out_debug",
            "--include-dir=..\\easipos\\EasiPOSX\\include",
            "--name=testprog",
            "-f",
            "-l"
        }
    },
    {
        type = "python";
        request = "launch";
        name = "Run EasiQtX";
        module = "EasiQTX";
        env = {
            EASIDEBUG = 1
        };
        pythonPath = function()
            return os.getenv("UserProfile") .. "\\dev\\easipos\\EasiQTX\\.venv\\Scripts\\python.exe"
        end,
    },
}
