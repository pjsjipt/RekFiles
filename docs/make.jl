using RekFiles
using Documenter

DocMeta.setdocmeta!(RekFiles, :DocTestSetup, :(using RekFiles); recursive=true)

makedocs(;
    modules=[RekFiles],
    authors="Paulo Jabardo <pjabardo@ipt.br>",
    repo="https://github.com/pjsjipt/RekFiles.jl/blob/{commit}{path}#{line}",
    sitename="RekFiles.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)
