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
lspconfig.clojure_lsp.setup({
    capabilities = capabilities
})
lspconfig.gopls.setup({
    cmd = {"gopls", "--remote=auto"},
    capabilities = capabilities
})
lspconfig.hls.setup({
    capabilities = capabilities
})
lspconfig.r_language_server.setup({
    capabilities = capabilities
})
lspconfig.ruff.setup({
    capabilities = capabilities
})
lspconfig.pyright.setup{
    settings = {
        pyright = {
            disableOrganizeImports = true,
        },
        python = {
            analysis = {
                ignore = { '*' },
            },
        },
    },
}
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
