-- Auto-load .vscode/launch.json from cwd, if present.
-- The second arg maps DAP adapter types to nvim filetypes so
-- entries with "type": "harbour-dbg" get registered under `harbour`.
local ok, vscode = pcall(require, "dap.ext.vscode")
if ok then
    vscode.load_launchjs(nil, { ["harbour-dbg"] = { "clipper" } })
end
