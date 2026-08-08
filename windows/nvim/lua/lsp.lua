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

-- C# setup
vim.lsp.config["roslyn_ls"] = {
    settings = {
        -- better performance
        ["csharp|background_analysis"] = {
            dotnet_analyzer_diagnostics_scope = "openFiles",
            dotnet_compiler_diagnostics_scope = "openFiles",
        },
    },
}
vim.lsp.enable("roslyn_ls")

-- JavaScript/TypeScript setup
vim.lsp.config["ts_go"] = {
    cmd = { "tsgo", "--lsp", "--stdio" },
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    root_markers = { "tsconfig.json", "jsconfig.json", "package.json" },
}
vim.lsp.enable("ts_go")

-- Lua setup
vim.lsp.config["luals"] = {
    cmd = { "lua-language-server", "--logpath=" .. vim.fn.stdpath("cache") .. "/luals.log" },
    root_markers = { { ".luarc.json", ".luarc.jsonc" }, ".git" },
    filetypes = { "lua" },
    on_attach = function(client, bufnr)
        if client:supports_method("textDocument/formatting") then
            vim.lsp.buf.format({ bufnr = bufnr })
        end
    end,
    settings = {
        Lua = {
            workspace = {
                checkThirdParty = false,
            },
            telemetry = {
                enable = false,
            },
            misc = {
                cachePath = vim.fn.stdpath("cache") .. "/luals",
            },
        },
    },
}
vim.lsp.enable("luals")

-- Harbour setup
local harbour = require("plugins.harbour")
vim.lsp.config["harbour_ls"] = {
    cmd = { "node", [[C:\Users\graham\dev\harbourCodeExtension\server\dist\hb_server.js]], "--stdio" },
    filetypes = { "clipper" },
    root_markers = { ".git" },
    on_attach = function(_, _)
        print("Harbour LSP attached")
    end,
    flags = {
        allow_incremental_sync = true,
        debounce_text_changes = 150,
    },
    settings = {
        harbour = {
            workspaceDepth = 3,
            extraIncludePaths = harbour.extraIncludePaths,
        },
        search = { exclude = {} },
        editor = { wordBasedSuggestions = true },
    },
}
vim.lsp.enable("harbour_ls")

-- Python setup
vim.lsp.config["ruff"] = {
    cmd = { "uv", "run", "ruff", "server" },
    on_attach = function(client, _)
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
vim.lsp.config["ty"] = {
    cmd = { "uv", "run", "ty", "server" },
    settings = {
    },
    root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt" },
    filetypes = { "python" },
}
vim.lsp.enable({ "ty", "ruff" })

-- Make auto-complete less annoying
vim.cmd("set completeopt+=noselect")

-- Inline diagnostics
vim.diagnostic.config({ virtual_text = true })
