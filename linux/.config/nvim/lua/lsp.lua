vim.lsp.config("*", {
    capabilities = vim.tbl_deep_extend("force",
        vim.lsp.protocol.make_client_capabilities(),
        {
            textDocument = {
                semanticTokens = { multilineTokenSupport = true },
                completion = {
                    completionItem = { snippetSupport = true },
                },
            },
        }),
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

-- CMake setup
vim.lsp.config["cmake"] = {
    cmd = { "cmake-language-server" },
    filetypes = { "cmake" },
    root_markers = { "CMakeLists.txt" },
}
vim.lsp.enable("cmake")

-- JavaScript/TypeScript setup
vim.lsp.config["ts_go"] = {
    cmd = { "tsgo", "--lsp", "--stdio" },
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    root_markers = { "tsconfig.json", "jsconfig.json", "package.json" },
}
vim.lsp.enable("ts_go")

-- Python setup
vim.lsp.config["ruff"] = {
    cmd = { "uv", "run", "ruff", "server" },
    on_attach = function(client, _)
        -- Disable capabilities that ty should handle
        client.server_capabilities.hoverProvider = false
        client.server_capabilities.definitionProvider = false
        client.server_capabilities.referencesProvider = false
        client.server_capabilities.documentSymbolProvider = false
        client.server_capabilities.imports = false
    end,
    root_markers = { "pyproject.toml", "ruff.toml" },
    filetypes = { "python" },
}
vim.lsp.config["ty"] = {
    cmd = { "uv", "run", "ty", "server" },
    settings = {
    },
    root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt" },
    filetypes = { "python" },
}
vim.lsp.enable({ "ty", "ruff" })

-- Rust setup
vim.lsp.config["rust_analyzer"] = {
    cmd = { "rust-analyzer" },
    workspace_required = true,
    on_attach = function(_, bufnr)
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
