-- DAP ADAPTER SETUP/CONFIGURATION
-- UI setup
require("neodev").setup({
  library = { plugins = { "nvim-dap-ui" }, types = true },
})
require("dapui").setup()

-- GDB
local dap = require("dap")
dap.adapters.gdb = {
    type = "executable",
    command = "gdb",
    args = { "-i", "dap" }
}
dap.configurations.cpp = {
    {
        name = "Launch GDB",
        type = "gdb",
        request = "launch",
        program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "~/dev/clrs/test/data_structures",
        stopAtBeginningOfMainSubprogram = false,
    },
}
dap.configurations.c = dap.configurations.cpp

-- debugpy
dap.adapters.python = {
    type = "executable";
    command = os.getenv("HOME") .. "/dev/easipos/EasiQTX/.venv/bin/python3.11";
    args = { "-m", "debugpy.adapter" };
}
dap.configurations.python = {
    {
        type = "python";
        request = "launch";
        name = "Launch EasiQtX";
        module = "EasiQtX";
        -- program = os.getenv("HOME") .. "/dev/hbxsharpconvert/hbxsharpconvert.py";
        pythonPath = function()
            return os.getenv("HOME") .. "/dev/easipos/EasiQTX/.venv/bin/python3.11"
        end,
        -- args = {
        --    "--input=../easipos/EasiPOSX/easiutil/adt.prg", 
        --    "--output=out_debug",
        --    "--include-dir=../easipos/EasiPOSX/include",
        --    "--name=testprog",
        --    "-l"
	    --}
    },
}
