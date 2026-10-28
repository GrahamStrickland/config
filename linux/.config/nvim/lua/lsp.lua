vim.lsp.config("*", {
    root_markers = { ".git" },
})

-- C/C++ setup
vim.lsp.config["clangd"] = {
    name = "clangd",
    cmd = { "clangd", "--background-index", "--clang-tidy" },
    initialization_options = {
        fallback_flags = { "-std=c++20" },
    },
    filetypes = { "c", "cpp" },
}
vim.lsp.enable("clangd")

-- JavaScript/TypeScript setup
vim.lsp.config["ts_go"] = {
    cmd = { "npx", "tsgo", "--lsp", "--stdio" },
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    root_markers = { "tsconfig.json", "jsconfig.json", "package.json" },
}
vim.lsp.enable("ts_go")

-- Python setup
vim.lsp.config["ruff"] = {
    cmd = { "uv", "run", "ruff", "server" },
    on_attach = function(client, _)
        -- Let ty handle hover
        client.server_capabilities.hoverProvider = false
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
