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

-- Julia setup
vim.lsp.config("julials", {
    cmd = {
        "julia",
        "--project=".."~/.julia/environments/lsp/",
        "--startup-file=no",
        "--history-file=no",
        "-e", [[
            using Pkg
            Pkg.instantiate()
            using LanguageServer
        depot_path = get(ENV, "JULIA_DEPOT_PATH", "")
        project_path = let
            dirname(something(
                ## 1. Finds an explicitly set project (JULIA_PROJECT)
                Base.load_path_expand((
                    p = get(ENV, "JULIA_PROJECT", nothing);
                        p === nothing ? nothing : isempty(p) ? nothing : p
                    )),
                        ## 2. Look for a Project.toml file in the current working directory,
                        ##    or parent directories, with $HOME as an upper boundary
                        Base.current_project(),
                        ## 3. First entry in the load path
                        get(Base.load_path(), 1, nothing),
                        ## 4. Fallback to default global environment,
                        ##    this is more or less unreachable
                    Base.load_path_expand("@v#.#"),
                ))
            end
                    @info "Running language server" VERSION pwd() project_path depot_path
                    server = LanguageServer.LanguageServerInstance(stdin, stdout, project_path, depot_path)
        server.runlinter = true
            run(server)
        ]]
    },
    filetypes = { "julia" },
    root_markers = { "Project.toml", "JuliaProject.toml" },
    settings = {}
})
vim.lsp.enable("julials")

-- LaTeX setup
vim.lsp.config["texlab"] = {
    cmd = { "texlab" },
    filetypes = { "tex" }
}
vim.lsp.enable("texlab")

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
            disableOrganizeImports = { true },
            analysis = {
                ignore = { "*" }
            }
        }
    },
    filetypes = { "python" },
}
vim.lsp.enable("basedpyright")

-- R setup
vim.lsp.config["r_language_server"] = {
    cmd = { "R", "--no-echo", "-e", "languageserver::run()" },
    filetypes = { "r", "R" },
}
vim.lsp.enable("r_language_server")

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
