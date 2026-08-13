-- Pre-plugin key mappings
-- Map the leader key to a space
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Page down/up and center
vim.api.nvim_set_keymap(
    "n",
    "<c-d>",
    "<c-d>zz",
    { noremap = true }
)
vim.api.nvim_set_keymap(
    "n",
    "<c-u>",
    "<c-u>zz",
    { noremap = true }
)

-- Remap terminal mode escape
vim.api.nvim_set_keymap(
    "t",
    "<esc>",
    "<c-\\><c-n>",
    { noremap = true }
)

vim.api.nvim_set_keymap(
    "n",
    "<leader>n",
    ":Lexplore<cr>",
    { silent = true }
)

-- LSP keybindings
vim.keymap.set(
    "n",
    "gd",
    function() vim.lsp.buf.definition() end
)
vim.keymap.set(
    "n",
    "gD",
    function() vim.lsp.buf.declaration() end
)
vim.keymap.set(
    "n",
    "gt",
    function() vim.lsp.buf.type_definition() end
)

-- Diagnostics/hover
vim.keymap.set(
    "n",
    "<leader>dn",
    function() vim.diagnostic.jump({ count = 1, float = true }) end
)
vim.keymap.set(
    "n",
    "<leader>dN",
    function() vim.diagnostic.jump({ count = -1, float = true }) end
)
vim.keymap.set(
    "n",
    "<leader>d",
    function() vim.diagnostic.open_float() end
)
vim.keymap.set(
    "n",
    "<leader>h",
    function() vim.lsp.buf.hover() end
)

-- Formatting
vim.keymap.set(
    "n",
    "<leader>cf",
    function()
        vim.lsp.buf.format()
    end,
    { noremap = true, silent = true }
)

-- Plugin-dependent keybindings
-- DAP mappings
vim.keymap.set(
    "n",
    "<F5>",
    function() require("dap").continue() end
)
vim.keymap.set(
    "n",
    "<S-F5>",
    function() require("dap").terminate() end
)
vim.keymap.set(
    "n",
    "<F10>",
    function() require("dap").step_over() end
)
vim.keymap.set(
    "n",
    "<F11>",
    function() require("dap").step_into() end
)
vim.keymap.set(
    "n",
    "<S-F11>",
    function() require("dap").step_out() end
)
vim.keymap.set(
    "n",
    "<F9>",
    function() require("dap").toggle_breakpoint() end
)
vim.keymap.set(
    "n",
    "<leader>db",
    function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end
)
vim.keymap.set(
    "n",
    "<leader>dr",
    function() require("dap").repl.open() end
)
vim.keymap.set(
    "n",
    "<leader>dl",
    function() require("dap").run_last() end
)

-- nvim-dap-ui key bindings
vim.keymap.set(
    "n",
    "<leader>do",
    function() require("dapui").open() end
)
vim.keymap.set(
    "n",
    "<leader>dc",
    function() require("dapui").close() end
)
vim.keymap.set(
    "n",
    "<leader>dt",
    function() require("dapui").toggle() end
)
