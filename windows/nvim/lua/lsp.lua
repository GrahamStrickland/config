-- LSP SETUP
vim.o.autocomplete = true

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
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    root_markers = { "tsconfig.json", "jsconfig.json", "package.json" },
    init_options = {
        hostInfo = "neovim",
    }
}
vim.lsp.enable("ts_ls")

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
vim.lsp.config["harbour_ls"] = {
    cmd = { "node", [[C:\Users\graham\dev\harbourCodeExtension\server\src\main.js]] },
    filetypes = { "clipper" },
    on_attach = function(_, _)
        print("Harbour LSP attached")
    end,
    flags = {
        allow_incremental_sync = true,
        debounce_text_changes = 150,
    }
}
vim.lsp.enable("harbour_ls")

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
