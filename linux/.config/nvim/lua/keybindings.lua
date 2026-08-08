-- Pre-plugin key mappings
-- Map the leader key to a space
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Save a file with leader-w
vim.api.nvim_set_keymap(
    "n",
    "<leader>w",
    ":w<cr>",
    { noremap = true }
)

-- Quit buffer with leader-q
vim.api.nvim_set_keymap(
    "n",
    "<leader>q",
    ":q<cr>",
    { noremap = true }
)

-- Fast split navigation with <Ctrl> + hjkl
vim.api.nvim_set_keymap(
    "n",
    "<c-h>",
    "<c-w><c-h>",
    { noremap = true }
)
vim.api.nvim_set_keymap(
    "n",
    "<c-j>",
    "<c-w><c-j>",
    { noremap = true }
)
vim.api.nvim_set_keymap(
    "n",
    "<c-k>",
    "<c-w><c-k>",
    { noremap = true }
)
vim.api.nvim_set_keymap(
    "n",
    "<c-l>",
    "<c-w><c-l>",
    { noremap = true }
)

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

-- Immediately add closing quotes or braces in insert mode
vim.api.nvim_set_keymap(
    "i",
    "(",
    "()<esc>i",
    { noremap = true }
)
vim.api.nvim_set_keymap(
    "i",
    "{",
    "{}<esc>i",
    { noremap = true }
)
vim.api.nvim_set_keymap(
    "i",
    "[",
    "[]<esc>i",
    { noremap = true }
)

-- Remap terminal mode escape
vim.api.nvim_set_keymap(
    "t",
    "<esc>",
    "<c-\\><c-n>",
    { noremap = true }
)

-- Browse files with netrw, replacing NERDTree
vim.api.nvim_set_keymap(
    "n",
    "<leader>n",
    ":Lexplore<cr>",
    { silent = true }
)

-- Pick a buffer, replacing CtrlPBuffer
vim.api.nvim_set_keymap(
    "n",
    "<c-b>",
    ":buffers<cr>:buffer ",
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
    function() require("dap").set_breakpoint() end
)
vim.keymap.set(
    "n",
    "<leader>dc",
    function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end
)
vim.keymap.set(
    "n",
    "<leader>dpr",
    function() require("dap").repl.open() end
)
vim.keymap.set(
    "n",
    "<leader>dpa",
    function() require("dap").run_last() end
)
vim.keymap.set(
    { "n", "v" },
    "<leader>dph",
    function() require("dap.ui.widgets").hover() end
)
vim.keymap.set(
    { "n", "v" },
    "<leader>dpp",
    function() require("dap.ui.widgets").preview() end
)
vim.keymap.set(
    "n",
    "<leader>dpf",
    function()
        local widgets = require("dap.ui.widgets")
        widgets.centered_float(widgets.frames)
    end
)
vim.keymap.set(
    "n",
    "<leader>dps",
    function()
        local widgets = require("dap.ui.widgets")
        widgets.centered_float(widgets.scopes)
    end
)

-- nvim-dap-view key bindings, replacing nvim-dap-ui
vim.keymap.set(
    "n",
    "<leader>dvo",
    function() require("dap-view").open() end
)
vim.keymap.set(
    "n",
    "<leader>dvc",
    function() require("dap-view").close() end
)
vim.keymap.set(
    "n",
    "<leader>dvt",
    function() require("dap-view").toggle() end
)
vim.keymap.set(
    "n",
    "<leader>dve",
    function() require("dap-view").virtual_text_enable() end
)
vim.keymap.set(
    "n",
    "<leader>dvd",
    function() require("dap-view").virtual_text_disable() end
)
vim.keymap.set(
    "n",
    "<leader>dvv",
    function() require("dap-view").virtual_text_toggle() end
)

-- Native LSP completion keybindings, replacing nvim-cmp
-- <cr>: accept the pum item, else newline
vim.keymap.set("i", "<cr>", function()
    if vim.fn.pumvisible() == 1 then
        return "<C-y>"
    end
    return "<CR>"
end, { expr = true, silent = true })

-- <tab>: next pum item, else literal tab
vim.keymap.set("i", "<tab>", function()
    if vim.fn.pumvisible() == 1 then
        return "<C-n>"
    end
    return "<Tab>"
end, { expr = true, silent = true })

-- <s-tab>: prev pum item, else literal shift-tab
vim.keymap.set("i", "<s-tab>", function()
    if vim.fn.pumvisible() == 1 then
        return "<C-p>"
    end
    return "<S-Tab>"
end, { expr = true, silent = true })
