local helpers = require("helpers")
local get_visual = helpers.get_visual
local line_begin = helpers.line_begin

return {
    s({trig = "fn", snippetType = "autosnippet"},
       fmta([[
                function <>() 

                    local <> := <>

                return <>
           ]],
                {
                    i(1),
                    i(2),
                    i(3),
                    i(4)
                }
       ),
       {condition = line_begin}
    ),
    s({trig = "pr", snippetType = "autosnippet"},
       fmta([[
                procedure <>() 

                return
           ]],
                { i(1) }
       ),
       {condition = line_begin}
    ),
    s({trig = "lc", snippetType = "autosnippet"},
       fmta("local <>", 
                { i(1) }
       ),
       {condition = line_begin}
    ),
    s({trig = "la", snippetType = "autosnippet"},
       fmta("local <> := <>", 
                { 
                    i(1),  
                    i(2)
                }
       ),
       {condition = line_begin}
    ),
    s({trig = "for", snippetType = "autosnippet"},
       fmta([[
                for <> := <> to <> 
                    <>
                next
        ]],
                { 
                    i(1),  
                    i(2),
                    i(3),
                    i(4)
                }
       ),
       {condition = line_begin}
    ),
    s({trig = "fos", snippetType = "autosnippet"},
       fmta([[
                for <> := <> to <> step <> 
                    <>
                next
        ]],
                { 
                    i(1),  
                    i(2),
                    i(3),
                    i(4),
                    i(5)
                }
       ),
       {condition = line_begin}
    ),
    s({trig = "if", snippetType = "autosnippet"},
       fmta([[
                if <> 
                    <>
                endif 
        ]],
                { 
                    i(1),  
                    i(2)
                }
       ),
       {condition = line_begin}
    ),
    s({trig = "ie", snippetType = "autosnippet"},
       fmta([[
                if <> 
                    <>
                else
                    <>
                endif 
        ]],
                { 
                    i(1),  
                    i(2),
                    i(3)
                }
       ),
       {condition = line_begin}
    ),
    s({trig = "is", snippetType = "autosnippet"},
       fmta([[
                if <> 
                    <>
                else if <>
                    <>
                endif 
        ]],
                { 
                    i(1),  
                    i(2),
                    i(3),
                    i(4)
                }
       ),
       {condition = line_begin}
    ),
    s({trig = "([^%w])iif", regTrig = true, wordTrig = false},
       fmta("<>iff(<>, <>, <>)",
                { 
                    f( function(_, snip) return snip.captures[1] end ),
                    i(1),  
                    i(2),
                    i(3)
                }
       )
    ),
    s({trig = "([^%w])cb", regTrig = true, wordTrig = false},
       fmta("<>{ |<>| <> }",
                { 
                    f( function(_, snip) return snip.captures[1] end ),
                    i(1),  
                    i(2)
                }
       )
    ),
    s({trig = "([^%w])ar", regTrig = true, wordTrig = false},
       fmta("<>{ <> }",
                { 
                    f( function(_, snip) return snip.captures[1] end ),
                    i(1) 
                }
       )
    ),
    s({trig = "([^%w])hs", regTrig = true, wordTrig = false},
       fmta("<>{ <> =>> <> }",
                { 
                    f( function(_, snip) return snip.captures[1] end ),
                    i(1),
                    i(2)
                }
       )
    )
}
