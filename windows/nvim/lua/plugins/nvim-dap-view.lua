-- nvim-dap-disasm SETUP
require("dap-view").setup({
    winbar = {
        sections = {
            "disassembly", "watches", "scopes", "exceptions", "breakpoints", "threads", "repl"
        },
    }
})
