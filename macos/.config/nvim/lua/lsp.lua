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
    filetypes = { "c", "cpp", "objc", "objcpp" },
}
vim.lsp.enable("clangd")

-- C# setup
local function roslyn_cmd()
    local pattern = "~/.dotnet/tools/.store/roslyn-language-server/*/"
        .. "roslyn-language-server.*/*/tools/net*/*/Microsoft.CodeAnalysis.LanguageServer.dll"
    local dlls = vim.fn.glob(vim.fn.expand(pattern), true, true)
    if #dlls > 0 then
        return { "dotnet", dlls[#dlls], "--stdio" }
    end
    return { "roslyn-language-server", "--stdio" }
end

vim.lsp.config["roslyn_ls"] = {
    cmd = roslyn_cmd(),
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

-- LaTeX setup
vim.lsp.enable("texlab")

-- Lua setup
vim.lsp.enable("lua_ls")

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

-- R setup
vim.lsp.enable("r_language_server")

-- Rust setup
vim.lsp.config["rust_analyzer"] = {
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
}
vim.lsp.enable("rust_analyzer")

-- QML setup
vim.lsp.enable("qmlls")
