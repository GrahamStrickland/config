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

-- LSP key mappings
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
vim.keymap.set(
    "n",
    "<leader>h",
    function() vim.lsp.buf.hover() end
)
vim.keymap.set(
    "n",
    "<leader>cf",
    function()
        vim.lsp.buf.format()
    end,
    { noremap = true, silent = true }
)

-- Diagnostics
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
    "<leader>dq",
    function() vim.diagnostic.setqflist() end
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
    "<F13>",
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
    "<F19>",
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

-- nvim-dap-ui key mappings
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

-- Telescope key mappings
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

-- oil.nvim key mappings
vim.keymap.set(
    "n",
    "-",
    "<CMD>Oil<CR>",
    { desc = "Open parent directory" }
)

-- LuaSnip + native LSP completion key mappings
local ls = require("luasnip")

-- <cr>: expand a snippet trigger, else accept the pum item, else newline
vim.keymap.set("i", "<cr>", function()
    if ls.expandable() then
        ls.expand()
        return ""
    elseif vim.fn.pumvisible() == 1 then
        return "<C-y>"
    end
    return "<CR>"
end, { expr = true, silent = true })

-- <tab>: next pum item, else jump forward in snippet, else literal tab
vim.keymap.set({ "i", "s" }, "<tab>", function()
    if vim.fn.pumvisible() == 1 then
        return "<C-n>"
    elseif ls.locally_jumpable(1) then
        ls.jump(1)
        return ""
    end
    return "<Tab>"
end, { expr = true, silent = true })

-- <s-tab>: prev pum item, else jump back in snippet, else literal shift-tab
vim.keymap.set({ "i", "s" }, "<s-tab>", function()
    if vim.fn.pumvisible() == 1 then
        return "<C-p>"
    elseif ls.locally_jumpable(-1) then
        ls.jump(-1)
        return ""
    end
    return "<S-Tab>"
end, { expr = true, silent = true })

-- <down>: cycle through LuaSnip choice nodes when active
vim.keymap.set({ "i", "s" }, "<down>", function()
    if ls.choice_active() then
        ls.change_choice(1)
        return ""
    end
    return "<Down>"
end, { expr = true, silent = true })

-- VimTeX key mappings
vim.keymap.set(
    "n",
    "<leader>wc",
    "<cmd>VimtexCountWords<cr>",
    { noremap = true }
)
vim.keymap.set(
    "n",
    "<leader>ll",
    "<cmd>VimtexCompile<cr>",
    { noremap = true }
)
vim.keymap.set(
    "n",
    "<leader>v",
    "<plug>(vimtex-view)",
    { noremap = true }
)
