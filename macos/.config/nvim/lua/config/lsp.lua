-- LSP SETUP
local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config("clangd", {
    name = "clangd",
    cmd = {"clangd", "--background-index", "--clang-tidy", "--log=verbose"},
    initialization_options = {
        fallback_flags = { "-std=c++20" },
    },
    capabilities = capabilities
})
vim.lsp.config("cmake", {
    capabilities = capabilities
})
vim.lsp.config("r_language_server", {
    capabilities = capabilities
})
vim.lsp.config("basedpyright", {
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
vim.lsp.config("ruff", {
    capabilities = capabilities,
    init_options = {
        settings = {
            args = { organizeImports = false }
        }
    }
})
vim.lsp.config("rust_analyzer", {
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
vim.lsp.config("texlab", {
    capabilities = capabilities
})
vim.lsp.config("ts_ls", {
    capabilities = capabilities
})
vim.lsp.config("julials", {
    on_attach = on_attach,
    capabilities = cmp_capabilities,
})
