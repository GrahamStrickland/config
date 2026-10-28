-- Defaults for each server come from nvim-lspconfig; settings here extend them.
vim.lsp.config("*", {
    root_markers = { ".git" },
})

-- C/C++ setup
vim.lsp.config["clangd"] = {
    cmd = { "clangd", "--background-index", "--clang-tidy" },
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
vim.lsp.config["lua_ls"] = {
    cmd = { "lua-language-server", "--logpath=" .. vim.fn.stdpath("cache") .. "/luals.log" },
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
vim.lsp.enable("lua_ls")

-- Harbour setup
local harbour = require("plugins.harbour")
vim.lsp.config["harbour_ls"] = {
    cmd = { "node", [[C:\Users\graham\dev\harbourCodeExtension\server\dist\hb_server.js]], "--stdio" },
    filetypes = { "clipper" },
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
        -- Let ty handle hover
        client.server_capabilities.hoverProvider = false
    end,
}
vim.lsp.config["ty"] = {
    cmd = { "uv", "run", "ty", "server" },
}
vim.lsp.enable({ "ty", "ruff" })

-- QML setup
vim.lsp.config("qmlls", { filetypes = { "qml" } })
vim.lsp.enable("qmlls")
