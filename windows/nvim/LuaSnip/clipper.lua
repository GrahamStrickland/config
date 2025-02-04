local helpers = require("helpers")
local get_visual = helpers.get_visual
local line_begin = helpers.line_begin

return {
    s({trig = "fn", snippetType = "autosnippet"},
       fmt([[
                function {}() 

                    local xVal := nil

                return xVal
           ]],
            {
                { i(1) }
            }
       ),
       {condition = line_begin}
    ),
    s({trig = "pr", snippetType = "autosnippet"},
       fmt([[
                procedure {}() 

                return
           ]],
            {
                { i(1) }
            }
       ),
       {condition = line_begin}
    )
}
