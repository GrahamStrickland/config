-- PRE-PLUGIN KEY MAPPINGS --
-- Map the leader key to a space
vim.g.mapleader = " "
vim.g.maplocalleader = "  "

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

-- MORE KEY MAPPINGS --
vim.call("plug#end")
-- Open NERDTree for viewing files
vim.api.nvim_set_keymap(
    "n",
    "<leader>n",
    ":NERDTreeToggle<cr>",
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

-- DAP Mappings
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
    "<leader>dpr", 
    function() require("dap").repl.open() end
)
vim.keymap.set(
    "n", 
    "<leader>dpa", 
    function() require("dap").run_last() end
)
vim.keymap.set(
    {"n", "v"}, 
    "<leader>dph", 
    function() require("dap.ui.widgets").hover() end
)
vim.keymap.set(
    {"n", "v"}, 
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
vim.keymap.set(
    "n",
    "<leader>duo",
    function() require("dapui").open() end
)
vim.keymap.set(
    "n",
    "<leader>duc",
    function() require("dapui").close() end
)
vim.keymap.set(
    "n",
    "<leader>dut",
    function() require("dapui").toggle() end
)

-- Telescope settings
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

-- Open diagnostics in floating window
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

-- LuaSnip keybindings -- see https://github.com/L3MON4D3/LuaSnip#keymaps
vim.cmd[[
" Use Tab to expand and jump through snippets
imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? "<Plug>luasnip-expand-or-jump" : "<Tab>" 
smap <silent><expr> <Tab> luasnip#jumpable(1) ? "<Plug>luasnip-jump-next" : "<Tab>"

" Use Shift-Tab to jump backwards through snippets
imap <silent><expr> <S-Tab> luasnip#jumpable(-1) ? "<Plug>luasnip-jump-prev" : "<S-Tab>"
smap <silent><expr> <S-Tab> luasnip#jumpable(-1) ? "<Plug>luasnip-jump-prev" : "<S-Tab>"

" Cycle forward through choice nodes with Control-f
imap <silent><expre> <C-f> luasnip#choice_active() ? "<Plug>luasnip-next-choice" : "<C-f>"
smap <silent><expre> <C-f> luasnip#choice_active() ? "<Plug>luasnip-next-choice" : "<C-f>"
]]

-- CSVView keybindings
vim.keymap.set(
    "n",
    "<leader>csv",
    function()
        require("csvview").enable()
    end,
    { noremap = true, silent = true }
)
vim.keymap.set(
    "n",
    "<leader>csd",
    function()
        require("csvview").disable()
    end,
    { noremap = true, silent = true }
)
vim.keymap.set(
    "n",
    "<leader>cst",
    function()
        require("csvview").toggle()
    end,
    { noremap = true, silent = true }
)

-- Goto Preview
vim.keymap.set(
    "n", 
    "<leader>gpd", 
    function()
        require("goto-preview").goto_preview_definition()
    end,
    {noremap=true}
)
vim.keymap.set(
    "n", 
    "<leader>gpt", 
    function()
        require("goto-preview").goto_preview_type_definition()
    end,
    {noremap=true}
)
vim.keymap.set(
    "n", 
    "<leader>gpi", 
    function()
        require("goto-preview").goto_preview_implementation()
    end,
    {noremap=true}
)
vim.keymap.set(
    "n", 
    "<leader>gpD", 
    function()
        require("goto-preview").goto_preview_declaration()
    end,
    {noremap=true}
)
vim.keymap.set(
    "n", 
    "<leader>gpr", 
    function()
        require("goto-preview").goto_preview_references()
    end,
    {noremap=true}
)
vim.keymap.set(
    "n", 
    "<leader>gP", 
    function()
        require("goto-preview").close_all_win()
    end,
    {noremap=true}
)
