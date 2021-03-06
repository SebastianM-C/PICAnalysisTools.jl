using PICAnalysisTools
using Documenter

makedocs(;
    modules=[PICAnalysisTools],
    authors="Sebastian Micluța-Câmpeanu <m.c.sebastian95@gmail.com> and contributors",
    repo="https://github.com/SebastianM-C/PICAnalysisTools.jl/blob/{commit}{path}#L{line}",
    sitename="PICAnalysisTools.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://SebastianM-C.github.io/PICAnalysisTools.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/SebastianM-C/PICAnalysisTools.jl",
)
