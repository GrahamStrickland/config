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

-- CMake setup
vim.lsp.config["cmake"] = {
    cmd = { "cmake-language-server" },
    filetypes = { "cmake" },
    root_markers = { "CMakeLists.txt" },
}
vim.lsp.enable("cmake")

-- Go setup
vim.lsp.config["gopls"] = {
    cmd = { "gopls", "--remote=auto" },
    filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
    root_markers = { "go.mod" },
}
vim.lsp.enable("gopls")

-- JavaScript/TypeScript setup
vim.lsp.config["ts_go"] = {
    cmd = { "tsgo", "--lsp", "--stdio" },
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "json" },
    root_markers = { "tsconfig.json", "jsconfig.json", "package.json" },
}
vim.lsp.enable("ts_go")

-- LaTeX setup
vim.lsp.config["texlab"] = {
    cmd = { "texlab" },
    filetypes = { "tex" }
}
vim.lsp.enable("texlab")

-- Lua setup
vim.lsp.config["luals"] = {
    cmd = { "lua-language-server" },
    root_markers = { ".luarc.json", ".luarc.jsonc" },
    filetypes = { "lua" },
}
vim.lsp.enable("luals")

-- Prolog setup
vim.lsp.config("prolog", {
    cmd = { "swipl",
        "-g", "use_module(library(lsp_server))",
        "-g", "lsp_server:main",
        "-t", "halt",
        "--", "stdio" },
    root_markers = { ".git", },
    filetypes = { "prolog" },
})

-- Override filetype settings
vim.g.filetype_pl = "prolog"

vim.lsp.enable({ "prolog" })

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

-- R setup
vim.lsp.config["r_language_server"] = {
    cmd = { "R", "--no-echo", "-e", "languageserver::run()" },
    filetypes = { "r" },
}
vim.lsp.enable("r_language_server")

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
