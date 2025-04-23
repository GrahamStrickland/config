local helpers = require("helpers")
local line_begin = helpers.line_begin

return {
    s({trig = "inc", dscr = "Include directive", snippetType = "autosnippet"},
       fmta('#include "<>"', 
                { i(1) }
       ),
       {condition = line_begin}
    ),
    s({trig = "def", dscr = "Definition directive", snippetType = "autosnippet"},
       fmta("#define <>", 
                { i(1) }
       ),
       {condition = line_begin}
    ),
    s({trig = "idf", dscr = "If defined directive", snippetType = "autosnippet"},
       fmta([[
            #ifdef <>
                <>
            #endif
        ]], 
                { 
                    i(1),
                    i(2)
                }
       ),
       {condition = line_begin}
    ),
    s({trig = "ind", dscr = "If not defined directive", ssnippetType = "autosnippet"},
       fmta([[
            #ifndef <>
                <>
            #endif
        ]], 
                { 
                    i(1),
                    i(2)
                }
       ),
       {condition = line_begin}
    ),
    s({trig = "fn", dscr = "Function definition", snippetType = "autosnippet"},
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
    s({trig = "pr", dscr = "Procedure definition", snippetType = "autosnippet"},
       fmta([[
                procedure <>() 

                return
           ]],
                { i(1) }
       ),
       {condition = line_begin}
    ),
    s({trig = "lc", dscr = "Local variable declaration", ssnippetType = "autosnippet"},
       fmta("local <>", 
                { i(1) }
       ),
       {condition = line_begin}
    ),
    s({trig = "la", dscr = "Local variable assignment", snippetType = "autosnippet"},
       fmta("local <> := <>", 
                { 
                    i(1),  
                    i(2)
                }
       ),
       {condition = line_begin}
    ),
    s({trig = "st", dscr = "Static variable declaration", snippetType = "autosnippet"},
       fmta("static <>", 
                { i(1) }
       ),
       {condition = line_begin}
    ),
    s({trig = "sa", dscr = "Static variable assignment", snippetType = "autosnippet"},
       fmta("static <> := <>", 
                { 
                    i(1),  
                    i(2)
                }
       ),
       {condition = line_begin}
    ),
    s({trig = "for", dscr = "For loop", snippetType = "autosnippet"},
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
    s({trig = "fos", dscr = "For loop with step", snippetType = "autosnippet"},
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
    s({trig = "fe", dscr = "For each loop", snippetType = "autosnippet"},
       fmta([[
                for each <> in <>
                    <>
                next
        ]],
                { 
                    i(1),  
                    i(2),
                    i(3)
                }
       ),
       {condition = line_begin}
    ),
    s({trig = "wh", dscr = "While loop", snippetType = "autosnippet"},
       fmta([[
                while <> 
                    <>
                end while
        ]],
                { 
                    i(1),  
                    i(2)
                }
       ),
       {condition = line_begin}
    ),
    s({trig = "if", dscr = "If statement", snippetType = "autosnippet"},
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
    s({trig = "ie", dscr = "If else statement", snippetType = "autosnippet"},
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
    s({trig = "is", dscr = "If else if statement", snippetType = "autosnippet"},
       fmta([[
                if <> 
                    <>
                elseif <>
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
    s({trig = "ile", dscr = "If else if else statement", snippetType = "autosnippet"},
       fmta([[
                if <> 
                    <>
                elseif <>
                    <>
                else
                    <>
                endif 
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
    s({trig = "dc", dscr = "Do case statement", snippetType = "autosnippet"},
       fmta([[
                do case
                    case <>
                        <>
                    case <>
                        <>
                    otherwise
                        <>
                endcase
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
    s({trig = "sc", dscr = "Switch statement", snippetType = "autosnippet"},
       fmta([[
                switch <>
                    case <>
                        <>
                        exit
                    case <>
                        <>
                        exit
                    otherwise
                        <>
                        exit
                endswitch
        ]],
                { 
                    i(1),  
                    i(2),
                    i(3),
                    i(4),
                    i(5),
                    i(6)
                }
       ),
       {condition = line_begin}
    ),
    s({trig = "bs", dscr = "Begin sequence statement", snippetType = "autosnippet"},
       fmta([[
                begin sequence with <>
                    <>
                recover with <>
                    <>
                end sequence
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
    s({trig = "([^%w])iif", dscr = "Ternary if", regTrig = true, wordTrig = false},
       fmta("<>iif(<>, <>, <>)",
                { 
                    f( function(_, snip) return snip.captures[1] end ),
                    i(1),  
                    i(2),
                    i(3)
                }
       )
    ),
    s({trig = "([^%w])cb", dscr = "Code block", regTrig = true, wordTrig = false},
       fmta("<>{ |<>| <> }",
                { 
                    f( function(_, snip) return snip.captures[1] end ),
                    i(1),  
                    i(2)
                }
       )
    ),
    s({trig = "([^%w])ar", dscr = "Array", regTrig = true, wordTrig = false},
       fmta("<>{ <> }",
                { 
                    f( function(_, snip) return snip.captures[1] end ),
                    i(1) 
                }
       )
    ),
    s({trig = "([^%w])hs", dscr = "Hash map", regTrig = true, wordTrig = false},
       fmta("<>{ <> =>> <> }",
                { 
                    f( function(_, snip) return snip.captures[1] end ),
                    i(1),
                    i(2)
                }
       )
    )
}
