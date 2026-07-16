local function find_jdtls_executable()
    local files = vim.fn.glob("/opt/homebrew/opt/jdtls/**/bin/jdtls", true, true)

    if #files == 0 then
        return "jdtls"
    end

    for _, file in ipairs(files) do
        if file:match("/opt/homebrew/opt/jdtls/bin/jdtls$") then
            return file
        end
    end

    return files[1]
end

local function get_root_dir()
    local root_files = { "gradlew", ".git", "mvnw" }
    local root = vim.fs.find(root_files, { upward = true })[1]

    if root then
        return vim.fs.dirname(root)
    end

    return vim.fn.getcwd()
end

-- Match the capabilities from the "*" config in lsp.lua
local function make_capabilities()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.semanticTokens = { multilineTokenSupport = true }
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    return capabilities
end

-- Give each project its own jdtls workspace/index so they never collide.
local root_dir = get_root_dir()
local workspace_dir = vim.fn.stdpath("cache") .. "/jdtls/workspace/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

-- Debug (java-debug) + test (vscode-java-test) bundles, loaded by jdtls to
-- enable nvim-dap breakpoints/stepping and the test runners.
local function jdtls_bundles()
    local base = vim.fn.stdpath("data") .. "/java-bundles"
    local bundles = vim.fn.glob(
        base .. "/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar",
        true, true)
    -- Exclude only the two non-OSGi artifacts: the fat test runner (loaded in
    -- the debuggee JVM) and the JaCoCo java-agent. Keep everything else.
    for _, jar in ipairs(vim.fn.glob(base .. "/vscode-java-test/server/*.jar", true, true)) do
        if not jar:match("runner%-jar%-with%-dependencies") and not jar:match("jacocoagent") then
            table.insert(bundles, jar)
        end
    end
    return bundles
end

-- jdtls-specific keymaps + inlay hints, wired up when the server attaches.
local function on_attach(_, bufnr)
    local jdtls = require("jdtls")
    local map = function(lhs, rhs, desc)
        vim.keymap.set("n", lhs, rhs, { buffer = bufnr, desc = desc })
    end

    map("<leader>oi", jdtls.organize_imports, "Java: organize imports")
    map("<leader>ev", jdtls.extract_variable, "Java: extract variable")
    map("<leader>ec", jdtls.extract_constant, "Java: extract constant")
    vim.keymap.set("v", "<leader>em", function() jdtls.extract_method(true) end,
        { buffer = bufnr, desc = "Java: extract method" })

    jdtls.setup_dap({ hotcodereplace = "auto" })

    -- NOTE: deliberately NOT calling setup_dap_main_class_configs() here. It
    -- eagerly resolves the classpath for every main class during on_attach, 
    -- i.e., before the Maven project has finished importing, which fails.
    map("<leader>tc", jdtls.test_class, "Java: debug test class")
    map("<leader>tm", jdtls.test_nearest_method, "Java: debug nearest test method")
    map("<leader>dm", function() require("jdtls.dap").setup_dap_main_class_configs() end,
        "Java: discover main-class debug configs")

    if vim.lsp.inlay_hint then
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end
end

local config = {
    cmd = { find_jdtls_executable(), "-data", workspace_dir },
    root_dir = root_dir,
    capabilities = make_capabilities(),
    on_attach = on_attach,
    settings = {
        java = {
            signatureHelp = { enabled = true },
            inlayHints = { parameterNames = { enabled = "all" } },
            completion = {
                favoriteStaticMembers = {
                    "org.junit.jupiter.api.Assertions.*",
                    "org.junit.jupiter.api.Assumptions.*",
                    "org.mockito.Mockito.*",
                    "java.util.Objects.requireNonNull",
                    "java.util.Objects.requireNonNullElse",
                },
                guessMethodArguments = true,
            },
            sources = {
                organizeImports = {
                    starThreshold = 9999,
                    staticStarThreshold = 9999,
                },
            },
            configuration = {
                -- Named JDKs jdtls can bind to a project's required environment.
                runtimes = {
                    {
                        name = "JavaSE-11",
                        path = "/opt/homebrew/opt/openjdk@11/libexec/openjdk.jdk/Contents/Home",
                        default = true,
                    },
                },
            },
        },
    },
    init_options = {
        bundles = jdtls_bundles(),
        extendedClientCapabilities = require("jdtls").extendedClientCapabilities,
    },
}
require("jdtls").start_or_attach(config)
