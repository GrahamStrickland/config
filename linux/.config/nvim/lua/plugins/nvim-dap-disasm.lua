require("dap-disasm").setup({
    -- Show winbar with buttons to step into the code with instruction granularity
    -- This settings is overriden (disabled) if the dapview integration is enabled and the plugin is installed
    winbar = {
        enabled = true,
        labels = {
            step_into = "Step Into",
            step_over = "Step Over",
            step_back = "Step Back",
        },
        order = {
            "step_into", "step_over", "step_back"
        }
    },

    sign = "DapStopped",

    ins_before_memref = 16,
    ins_after_memref = 16,

    columns = {
        "address",
        "instructionBytes",
        "instruction",
    },
})
