-- MacOS Neovim Configuration
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

-- Open diagnostics in floating window
vim.keymap.set(
    "n",
    "<leader>o",
    function() vim.diagnostic.open_float() end
)

-- PLUGIN MANAGEMENT --
-- Manage plugins with vim-plug.
local vim = vim
local Plug = vim.fn["plug#"]
vim.call("plug#begin")

Plug("scrooloose/nerdtree")
Plug("tpope/vim-unimpaired")
Plug("tpope/vim-vinegar")
Plug("tpope/vim-fugitive")
Plug("ctrlpvim/ctrlp.vim")
Plug("mileszs/ack.vim")
Plug("easymotion/vim-easymotion")
Plug("doums/darcula")
Plug("tomasiser/vim-code-dark")
Plug("morhetz/gruvbox")
Plug("christoomey/vim-tmux-navigator")
Plug("tomtom/tcomment_vim")
Plug("neovim/nvim-lspconfig")
Plug("nvim-lua/lsp-status.nvim")
Plug("glepnir/lspsaga.nvim")
Plug("hrsh7th/cmp-nvim-lsp")
Plug("hrsh7th/cmp-buffer")
Plug("hrsh7th/cmp-path")
Plug("hrsh7th/cmp-cmdline")
Plug("hrsh7th/nvim-cmp")
Plug("L3MON4D3/LuaSnip")
Plug("saadparwaiz1/cmp_luasnip")
Plug("nvim-lua/plenary.nvim")
Plug("nvim-telescope/telescope.nvim")
Plug("kosayoda/nvim-lightbulb")
Plug("rmagatti/goto-preview")
Plug("mfussenegger/nvim-dap")
Plug("Julian/lean.nvim")
Plug("andrewradev/switch.vim")
Plug("nvim-treesitter/nvim-treesitter", { ["do"] = function()
    vim.fn["TSUpdate"]()
end })

vim.call("plug#end")

-- PLUGIN-DEPENDENT KEY MAPPINGS --
-- Open NERDTree for viewing files
vim.api.nvim_set_keymap(
    "n",
    "<leader>n",
    ":NERDTreeToggle<cr>",
    { noremap = true }
)

-- Map Ctrlp buffer mode to Ctrl + B
vim.api.nvim_set_keymap(
    "n",
    "<c-b>",
    "CtrlPBuffer<cr>",
    { noremap = true }
)

-- DAP mappings
vim.keymap.set(
    "n", 
    "<leader>dc", 
    function() require("dap").continue() end
)
vim.keymap.set(
    "n", 
    "<leader>ds", 
    function() require("dap").step_over() end
)
vim.keymap.set(
    "n", 
    "<leader>di", 
    function() require("dap").step_into() end
)
vim.keymap.set(
    "n", 
    "<leader>dt", 
    function() require("dap").step_out() end
)
vim.keymap.set(
    "n", 
    "<leader>dt", 
    function() require("dap").toggle_breakpoint() end
)
vim.keymap.set(
    "n", 
    "<leader>dpb", 
    function() require("dap").set_breakpoint() end
)
vim.keymap.set(
    "n", 
    "<leader>dl", 
    function() require("dap").set_breakpoint(
            nil, 
            nil, 
            vim.fn.input("Log point message: ")
        ) 
    end
)
vim.keymap.set(
    "n", 
    "<leader>dr", 
    function() require("dap").repl.open() end
)
vim.keymap.set(
    "n", 
    "<leader>da", 
    function() require("dap").run_last() end
)
vim.keymap.set(
    {"n", "v"}, 
    "<leader>dh", 
    function() require("dap.ui.widgets").hover() end
)
vim.keymap.set(
    {"n", "v"}, 
    "<leader>dp", 
    function() require("dap.ui.widgets").preview() end
)
vim.keymap.set(
    "n", 
    "<leader>df", 
    function()
        local widgets = require("dap.ui.widgets")
        widgets.centered_float(widgets.frames)
    end
)
vim.keymap.set(
    "n", 
    "<leader>ds", 
    function()
        local widgets = require("dap.ui.widgets")
        widgets.centered_float(widgets.scopes)
    end
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

-- OPTION SETUP --
vim.g.NERDTreeHijackNetrw = 0

vim.opt.number = true           -- Add line numbers to document.
vim.opt.relativenumber = true   -- Add relative line numbers to document.
vim.opt.autoread = true         -- Automatically reload files.
vim.opt.autoindent = true	    -- Respect indentation when starting a new line.
vim.opt.expandtab = true		-- Expand tabs to spaces. Essential in Python.
vim.opt.tabstop = 4			    -- Number of spaces tab is counted for.
vim.opt.shiftwidth = 4		    -- Number of spaces to use for autoindent.
vim.opt.background = "dark"     -- Set to dark mode.
vim.opt.hlsearch = true         -- Highlight search results.
vim.opt.incsearch = true        -- Show where search pattern matches.
vim.opt.clipboard = "unnamed"   -- Copy into system (*) register.

-- Adapted for MacOS from 
-- https://toddknutson.bio/posts/how-to-enable-neovim-undo-backup-and-swap-files-when-switching-linux-groups/
USER = os.getenv("USER")
SWAPDIR = "/Users/" .. USER .. "/nvim/swap//"
BACKUPDIR = "/Users/" .. USER .. "/nvim/backup//"
UNDODIR = "/Users/" .. USER .. "/nvim/undo//"

if vim.fn.isdirectory(SWAPDIR) == 0 then
	vim.fn.mkdir(SWAPDIR, "p", "0o700")
end

if vim.fn.isdirectory(BACKUPDIR) == 0 then
	vim.fn.mkdir(BACKUPDIR, "p", "0o700")
end

if vim.fn.isdirectory(UNDODIR) == 0 then
	vim.fn.mkdir(UNDODIR, "p", "0o700")
end

-- Enable swap, backup, and persistant undo
vim.opt.directory = SWAPDIR
vim.opt.backupdir = BACKUPDIR
vim.opt.undodir = UNDODIR
vim.opt.swapfile = true
vim.opt.backup = true
vim.opt.undofile = true

-- Append backup files with timestamp
vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function()
		local extension = "~" .. vim.fn.strftime("%Y-%m-%d-%H%M%S")
		vim.o.backupext = extension
	end,
})

-- FURTHER SETUP --
vim.cmd("colorscheme gruvbox")

require("lean").setup({
    lsp = { on_attach = on_attach },
    mappings = true,
})

require("nvim-lightbulb").setup({
    autocmd = { enabled = true }
})

require("goto-preview").setup({})

-- nvim-cmp setup
local cmp = require"cmp"

cmp.setup({
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ["<c-b>"] = cmp.mapping.scroll_docs(-4),
        ["<c-f>"] = cmp.mapping.scroll_docs(4),
        ["<c-Space>"] = cmp.mapping.complete(),
        ["<c-e>"] = cmp.mapping.abort(),
        ["<cr>"] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
    }, {
        { name = "buffer" },
    })
})
cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "buffer" }
    }
})
cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = "path" }
    }, {
        { name = "cmdline" }
    }),
    matching = { disallow_symbol_nonprefix_matching = false }
})

-- LSP SETUP
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require("lspconfig")
lspconfig.clangd.setup({
    name = "clangd",
    cmd = {"clangd", "--background-index", "--clang-tidy", "--log=verbose"},
    initialization_options = {
        fallback_flags = { "-std=c++20" },
    },
    capabilities = capabilities
})
lspconfig.cmake.setup({
    capabilities = capabilities
})
lspconfig.hls.setup({
    capabilities = capabilities
})
lspconfig.pyright.setup({
    capabilities = capabilities
})
lspconfig.texlab.setup({
    capabilities = capabilities
})

-- DAP ADAPTER/CONFIGURATION SETUP 
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
        cwd = "~/dev/clrs/test/algorithms",
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
        module = "EasiQTX";
        name = "Launch debugpy";
        pythonPath = function()
            return os.getenv("HOME") .. "/dev/easipos/EasiQTX/.venv/bin/python3.11"
        end,
    },
}

