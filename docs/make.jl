using biomass_docs
using Documenter

makedocs(;
    modules=[biomass_docs],
    authors="Hiroaki Imoto <himoto@protein.osaka-u.ac.jp>",
    repo="https://github.com/okadalabipr/biomass_docs.jl/blob/{commit}{path}#L{line}",
    sitename="BioMASS.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://okadalabipr.github.io/biomass_docs.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/okadalabipr/biomass_docs.jl",
)
