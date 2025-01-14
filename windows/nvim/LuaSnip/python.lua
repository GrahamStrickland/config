local helpers = require("helpers")
local line_begin = helpers.line_begin

return {
    s({trig = "im", dscr = "Import", snippetType = "autosnippet"},
        fmta("import <>",
            { i(1) }
        ),
        {condition = line_begin}
    ),
    s({trig = "fr", dscr = "Sub-import", snippetType = "autosnippet"},
        fmta("from <> import <>",
            { 
                i(1),
                i(2)
            }
        ),
        {condition = line_begin}
    ),
    s({trig = "doc", dscr = "Function", snippetType = "autosnippet"},
        fmta([[
            """<>.

            Args:
                <>: <>.

            Returns:
                <>.

            Raises:
              <>: <>.
            """
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
    s({trig = "fn", dscr = "Function", snippetType = "autosnippet"},
        fmta([[
        def <>():
            return <> 
        ]],
            { 
                i(1),
                i(2)
            }
        ),
        {condition = line_begin}
    ),
    s({trig = "ft", dscr = "Function with return type", snippetType = "autosnippet"},
        fmt([[
        def {}() -> {}:
            return {}
        ]],
            { 
                i(1),
                i(2), 
                i(3)
            }
        ),
        {condition = line_begin}
    ),
    s({trig = "fv", dscr = "Function with None return type", snippetType = "autosnippet"},
        fmt([[
        def {}() -> None:
            return
        ]],
            { i(1) }
        ),
        {condition = line_begin}
    ),
    s({trig = "cs", dscr = "Class", snippetType = "autosnippet"},
        fmta([[
        class <>:
            
        ]],
            { i(1) }
        ),
        {condition = line_begin}
    ),
    s({trig = "sc", dscr = "Sub-class", snippetType = "autosnippet"},
        fmt([[
        class {}({}):
            def __init__(self) -> None:
                super().__init__(self)
                return
        ]],
            { 
                i(1), 
                i(2) 
            }
        ),
        {condition = line_begin}
    ),
    s({trig = "ds", dscr = "Dataclass", snippetType = "autosnippet"},
        fmta([[
        @dataclass
        class <>:
            <>: <>
        ]],
            { 
                i(1),
                i(2),
                i(3)
            }
        ),
        {condition = line_begin}
    ),
    s({trig = "mt", dscr = "Method", snippetType = "autosnippet"},
        fmta([[
                def <>(self):
                    return <>  
        ]],
            { 
                i(1),
                i(2)
            }
        ),
        {condition = line_begin}
    ),
    s({trig = "tm", dscr = "Method with return type", snippetType = "autosnippet"},
        fmt([[
                def {}(self) -> {}:
                    return {}
        ]],
            { 
                i(1), 
                i(2), 
                i(3)
            }
        ),
        {condition = line_begin}
    ),
    s({trig = "ls", dscr = "List declaration", snippetType = "autosnippet"},
        fmta("<> = [<>]",
            { 
                i(1), 
                i(2) 
            }
        ),
        {condition = line_begin}
    ),
    s({trig = "lc", dscr = "List comprehension", snippetType = "autosnippet"},
        fmta("[<> for <> in <>]",
            { 
                i(1), 
                rep(1),
                i(2)
            }
        )
    ),
    s({trig = "dt", dscr = "Dict declaration", snippetType = "autosnippet"},
        fmta("<> = {<>: <>}",
            { 
                i(1), 
                i(2), 
                i(3)
            }
        ),
        {condition = line_begin}
    ),
    s({trig = "dc", dscr = "Dict comprehension", snippetType = "autosnippet"},
        fmta("{<>: <> for <>, <> in <>}",
            { 
                i(1), 
                i(2),
                rep(1),
                rep(1),
                i(3)
            }
        )
    ),
    s({trig = "iif", dscr = "Ternary if", snippetType = "autosnippet"},
        fmta("<> if <> else <>",
            { 
                i(1), 
                i(2),
                i(3)
            }
        )
    ),
    s({trig = "tst", dscr = "Pytest unit test", snippetType = "autosnippet"},
        fmt([[
                def test_{}() -> None:
                    res = {}
                    assert res = {}
        ]],
            { 
                i(1), 
                i(2), 
                i(3)
            }
        ),
        {condition = line_begin}
    ),
    s({trig = "tsc", dscr = "Pytest unit test class", snippetType = "autosnippet"},
        fmt([[
            class Test{}:
                def test_{}(self) -> None:
                    res = {}
                    assert res = {}
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
    s({trig = "tsm", dscr = "Pytest unit test class method", snippetType = "autosnippet"},
        fmt([[
                def test_{}(self) -> None:
                    res = {}
                    assert res = {}
        ]],
            { 
                i(1), 
                i(2), 
                i(3)
            }
        ),
        {condition = line_begin}
    ),
}
