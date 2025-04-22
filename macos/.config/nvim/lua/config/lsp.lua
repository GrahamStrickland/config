-- LSP SETUP
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require("lspconfig")
local util = require("lspconfig.util")

lspconfig.clangd.setup({
    name = "clangd",
    cmd = {"clangd", "--background-index", "--clang-tidy", "--log=verbose"},
    initialization_options = {
        fallback_flags = { "-std=c++20" },
    },
    capabilities = capabilities
})
lspconfig.cmake.setup({
    capabilities = capabilities
})
lspconfig.clojure_lsp.setup({
    capabilities = capabilities
})
lspconfig.gopls.setup({
    cmd = {"gopls", "--remote=auto"},
    capabilities = capabilities
})
lspconfig.hls.setup({
    capabilities = capabilities,
    cmd = { "haskell-language-server-wrapper", "--lsp" },
    filetypes = { "haskell", "lhaskell" },
    root_dir = function(bufnr, on_dir)
        local fname = vim.api.nvim_buf_get_name(bufnr)
        on_dir(util.root_pattern("hie.yaml", "stack.yaml", "cabal.project", "*.cabal", "package.yaml")(fname))
    end,
    settings = {
        haskell = {
            formattingProvider = "ormolu",
            cabalFormattingProvider = "cabalfmt",
        },
    },
})
lspconfig.r_language_server.setup({
    capabilities = capabilities
})
lspconfig.basedpyright.setup({
    capabilies = capabilities,
    settings = {
        basedpyright = {
            disableOrganizeImports = { true },
            analysis = {
                ignore = { "*" }
            }
        }
    }
})
lspconfig.ruff.setup({
    capabilities = capabilities,
    init_options = {
        settings = {
            args = { organizeImports = false }
        }
    }
})
lspconfig.rust_analyzer.setup({
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
    }

})
lspconfig.texlab.setup({
    capabilities = capabilities
})
lspconfig.ts_ls.setup({
    capabilities = capabilities
})
