return {
    s(
        {trig=";a", snippetType="autosnippet"},
        {
            t("\\alpha"),
        }
    ),
    s(
        {trig=";b", snippetType="autosnippet"},
        {
            t("\\beta"),
        }
    ),
    s(
        {trig=";g", snippetType="autosnippet"},
        {
            t("\\gamma"),
        }
    ),
    s(
        {trig="tt", dscr="Expands 'tt' into '\texttt{}'"},
        fmta(
            "\\texttt{<>}",
            { i(1) },
        ),
    ),
    s(
        {trig="ff", dscr="Expands 'ff' into '\frac{}{}'"},
        fmta(
            "\\frac{<>}{<>}",
            { 
                i(1),
                i(2)
            },
        ),
    ),
    s(
        {trig="eq", dscr="A LaTeX equation environment"},
        fmta(
            [[
                \begin{equation}
                    <>
                \end{equation}
            ]],
            { i(1) },
        ),
    ),
}
