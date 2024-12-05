local helpers = require("helpers")
local get_visual = helpers.get_visual
local line_begin = helpers.line_begin

local tex_utils = {}

tex_utils.in_mathzone = function()
    return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end

tex_utils.in_text = function()
    return not tex_utils.in_mathzone()
end

tex_utils.in_comment = function()
    return vim.fn["vimtex#syntax#in_comment"]() == 1
end

tex_utils.in_env = function(name)
    local is_inside = vim.fn["vimtex#env#is_inside"](name)
    return (is_inside[1] > 0 and is_inside[2] > 0)
end

tex_utils.in_equation = function()
    return tex_utils.in_env("equation")
end

tex_utils.in_itemize = function()
    return tex_utils.in_env("itemize")
end

tex_utils.in_tikz = function()
    return tex_utils.in_env("tikzpicture")
end


return {
    s({trig = ";a", snippetType = "autosnippet"},
        {
            t("\\alpha"),
        }
    ),
    s({trig = ";b", snippetType = "autosnippet"},
        {
            t("\\beta"),
        }
    ),
    s({trig = ";g", snippetType = "autosnippet"},
        {
            t("\\gamma"),
        }
    ),
    s({trig = "([%a%)%}])00", regTrig = true, wordTrig = false, snippetType = "autosnippet"},
        fmta("<>_{<>}",
            {
                f( function(_, snip) return snip.captures[1] end ),
                t("0")
            }
        )
    ),
    s({trig = "([^%a])ee", regTrig = true, wordTrig = false},
        fmta("<>e^{<>}",
            {
                f( function(_, snip) return snip.captures[1] end),
                d(1, get_visual),
            }
        )
    ),
    s({trig = "([^%a])mm", wordTrig = false, regTrig = true, snippetType = "autosnippet", dscr = "Expands 'mm' into '$$'"},
        fmta("<>$<>$",
            { 
                f( function(_, snip) return snip.captures[1] end),
                d(1, get_visual), 
            }
        )
    ),
    s({trig = "bb", dscr = "Expands 'bb' into '[]'"},
        fmta([[
                [
                    <>
                ]
             ]],
            { 
                d(1, get_visual), 
            }
        )
    ),
    s({trig = "h1", dscr = "Top-level section", snippetType = "autosnippet"},
        fmta([[\section*{<>}]],
            { i(1) }
        ),
        {condition = line_begin}
    ),
    s({trig = "tt", dscr = "Expands 'tt' into '\texttt{}'"},
        fmta("\\texttt{<>}",
            { 
                d(1, get_visual), 
            }
        )
    ),
    s({trig = "tii", dscr = "Expands 'tii' into '\textit{}'"},
        fmta("\\textit{<>}",
            {
                d(1, get_visual),
            }
        )
    ),
    s({trig = "ff", dscr = "Expands 'ff' into '\frac{}{}'", snippetType = "autosnippet"},
        fmt(
            "\\frac{<>}{<>}",
            {
                i(1),
                i(2)
            },
            {delimiters = "<>"}
        ),
        {condition = tex_utils.in_mathzone}
    ),
    s({trig = "eq", dscr = "Expands 'eq' into an equation environment"},
        fmta(
            [[
                \begin{equation*}
                    <>
                \end{equation*}
            ]],
            { i(0) }
        )
    ),
    s({trig = "new", snippetType = "autosnippet"},
        fmta(
            [[
                \begin{<>}
                    <>
                \end{<>}
            ]],
            {
                i(1),
                i(2),
                rep(1),
            }
        ),
        {condition = line_begin}
    ),
    s({trig = "dd"},
        fmta("\\draw [<>]",
            {
                i(1, "params"),
            }
        ),
        {condition = tex_utils.in_tikz}
    ),
    s({trig = "hr", dscr = "The hyperref package's href{}{} command (for url links)"},
        fmta(
            [[\href{<>}{<>}]],
            {
                i(1, "url"),
                i(2, "display name"),
            }
        )
    )
}
