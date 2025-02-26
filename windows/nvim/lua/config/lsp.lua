-- LSP SETUP
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require("lspconfig")
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
    capabilities = capabilities
})
