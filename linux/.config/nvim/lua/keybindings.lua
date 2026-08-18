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
    "<leader>o",
    function() vim.diagnostic.open_float() end
)
vim.keymap.set(
    "n",
    "<leader>h",
    function() vim.lsp.buf.hover() end
)

-- Code actions
vim.keymap.set(
    "n",
    "<leader>ca",
    function()
        vim.lsp.buf.code_action()
    end,
    { noremap = true, silent = true }
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

-- Plugin-dependent key mappings
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

-- Telescope key bindings
local builtin = require("telescope.builtin")
vim.keymap.set(
    "n",
    "<leader>ff",
    builtin.find_files,
    {}
)
vim.keymap.set(
    "n",
    "<leader>fg",
    builtin.live_grep,
    {}
)
vim.keymap.set(
    "n",
    "<leader>fb",
    builtin.buffers,
    {}
)
vim.keymap.set(
    "n",
    "<leader>fh",
    builtin.help_tags,
    {}
)
vim.keymap.set(
    "n",
    "<leader>fd",
    builtin.lsp_definitions,
    {}
)
vim.keymap.set(
    "n",
    "<leader>fi",
    builtin.lsp_implementations,
    {}
)
vim.keymap.set(
    "n",
    "<leader>fr",
    builtin.lsp_references,
    {}
)

-- oil.nvim keybindings
vim.keymap.set(
    "n",
    "-",
    "<CMD>Oil<CR>",
    { desc = "Open parent directory" }
)

