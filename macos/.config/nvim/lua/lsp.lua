-- LSP SETUP
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

-- Clojure setup
vim.lsp.config["clojure_lsp"] = {
    cmd = { "clojure-lsp" },
    filetypes = { "clojure" },
    root_markers = { "project.clj", "deps.edn", "build.boot", "shadow-cljs.edn", ".git" },
    single_file_support = true,
}
vim.lsp.enable("clojure_lsp")

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
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    root_markers = { "tsconfig.json", "jsconfig.json", "package.json" },
    init_options = {
        hostInfo = "neovim",
    }
}
vim.lsp.enable("ts_ls")

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
