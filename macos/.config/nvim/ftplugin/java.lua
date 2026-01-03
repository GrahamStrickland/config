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

local config = {
    cmd = { find_jdtls_executable() },
    root_dir = get_root_dir(),
}
require("jdtls").start_or_attach(config)
