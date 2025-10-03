-- LSP SETUP
vim.lsp.config("*", {
    capabilities = {
        textDocument = {
            semanticTokens = {
                multilineTokenSupport = true,
            }
        }
    },
    root_markers = { ".git" },
})
-- C/C++ setup
vim.lsp.config["clangd"] = {
    name = "clangd",
    cmd = { "clangd", "--background-index", "--clang-tidy", "--log=verbose" },
    initialization_options = {
        fallback_flags = { "-std=c++20" },
    },
    filetypes = { "c", "cpp" },
}
vim.lsp.enable("clangd")

-- JavaScript/TypeScript setup
vim.lsp.config["ts_ls"] = {
    cmd = { "typescript-language-server", "--stdio" },
    filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
    root_markers = { "tsconfig.json", "jsconfig.json", "package.json" },
    init_options = {
        hostInfo = "neovim",
    }
}
vim.lsp.enable("ts_ls")

-- Lua setup
vim.lsp.config["luals"] = {
    cmd = { "lua-language-server" },
    root_markers = { {".luarc.json", ".luarc.jsonc"}, ".git" },
    filetypes = { "lua" },
}
vim.lsp.enable("luals")

-- Python setup
vim.lsp.config["basedpyright"] = {
    cmd = { "uv", "run", "basedpyright-langserver", "--stdio" },
    settings = {
        basedpyright = {
            analysis = {
                autoSearchPaths = true,
                diagnosticMode = "workspace",
                useLibraryCodeForTypes = true,
                autoImportCompletion = true,
                typeCheckingMode = "standard",
            },
            disableOrganizeImports = true,
        },
    },
    root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt" },
    filetypes = { "python" },
}
vim.lsp.config["ruff"] = {
    cmd = { "uv", "run", "ruff", "server" },
    on_attach = function(client, bufnr)
        -- Disable capabilities that basedpyright should handle
        client.server_capabilities.hoverProvider = false
        client.server_capabilities.definitionProvider = false
        client.server_capabilities.referencesProvider = false
        client.server_capabilities.documentSymbolProvider = false
        client.server_capabilities.imports = false
    end,
    root_markers = { "pyproject.toml", "ruff.toml" },
    filetypes = { "python" },
}
vim.lsp.enable({ "basedpyright", "ruff" })

-- Rust setup
vim.lsp.config["rust_analyzer"] = {
    cmd = { "rust-analyzer" },
    workspace_required = true,
    on_attach = function(client, bufnr)
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end,
    settings = {
        ["rust-analyzer"] = {
            imports = {
                granularity = {
                    group = "module",
                },
                prefix = "self",
            },
            cargo = {
                buildScripts = {
                    enable = true,
                },
            },
            procMacro = {
                enable = true
            },
        }
    },
    filetypes = { "rust" },
}
vim.lsp.enable("rust_analyzer")

-- Setup auto-completion
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client:supports_method("textDocument/completion") then
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
        end
    end,
})

-- Make auto-complete less annoying
vim.cmd("set completeopt+=noselect")
