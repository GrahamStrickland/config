local M = {}

local ls = require("luasnip")
local sn = ls.snippet_node
local i = ls.insert_node

function M.get_visual(args, parent)
    if (#parent.snippet.env.LS_SELECT_RAW > 0) then
        return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
    else
        return sn(nil, i(1, ""))
    end
end

M.line_begin = require("luasnip.extras.expand_conditions").line_begin

return M
