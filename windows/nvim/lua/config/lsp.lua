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

-- C# setup
vim.lsp.config["roslyn"] = {
    cmd = { [[C:\Users\graham\AppData\Local\Microsoft\VisualStudio\Roslyn\content\LanguageServer\win-x64\Microsoft.CodeAnalysis.LanguageServer]], "--logLevel=Information", [[--extensionLogDirectory=C:\Users\graham\AppData\Local\nvim-data]], "--stdio" },
    on_attach = function()
        print("Roslyn server attached.")
    end,
    settings = {
        ["csharp|inlay_hints"] = {
            csharp_enable_inlay_hints_for_implicit_object_creation = true,
            csharp_enable_inlay_hints_for_implicit_variable_types = true,
        },
        ["csharp|code_lens"] = {
            dotnet_enable_references_code_lens = true,
        },
    },
}
vim.lsp.enable("roslyn")

-- CMake setup
vim.lsp.config["cmake"] = {
    cmd = { "cmake-language-server" },
    filetypes = { "cmake" },
    root_markers = { "CMakeLists.txt" },
}
vim.lsp.enable("cmake")

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
    cmd = { "lua-language-server", "--logpath=" .. vim.fn.stdpath("cache") .. "/luals.log" },
    root_markers = { {".luarc.json", ".luarc.jsonc"}, ".git" },
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

-- Python setup
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

-- Setup Harper for spell checking
vim.lsp.config["harper_ls"] = {
    cmd = { "harper-ls", "--stdio" },
    settings = {
        ["harper-ls"] = {
             userDictPath = "",
             workspaceDictPath = "",
             fileDictPath = "",
             linters = {
                 SpellCheck = true,
                 SpelledNumbers = false,
                 AnA = true,
                 SentenceCapitalization = true,
                 UnclosedQuotes = true,
                 WrongQuotes = false,
                 LongSentences = true,
                 RepeatedWords = true,
                 Spaces = true,
                 Matcher = true,
                 CorrectNumberSuffix = true
             },
             codeActions = {
                ForceStable = false
             },
             markdown = {
                IgnoreLinkTitle = false
             },
             diagnosticSeverity = "hint",
             isolateEnglish = false,
             dialect = "British",
             maxFileLength = 120000,
             ignoredLintsPath = "",
             excludePatterns = {}
        }
    },
    filetypes = { 
        "gitcommit",
        "html",
        "markdown",
        "toml",
        "tex",
        "text"
    },
}
vim.lsp.enable("harper_ls")

-- Make auto-complete less annoying
vim.cmd("set completeopt+=noselect")
