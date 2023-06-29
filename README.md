# MINDFulNotebookExamples

This is a repository containing some notebook examples for [MINDFul.jl](https://github.com/UniStuttgart-IKR/MINDFul.jl)

See the github pages deployment of this repository:

https://unistuttgart-ikr.github.io/MINDFulNotebookExamples.jl/

`Manifest.toml` is checked in since some still unregistered repositories are required:
- MINDFulCompanion
  - still unregisted 
- NestedGraphsIO https://github.com/UniStuttgart-IKR/NestedGraphsIO.jl#main
  - will eventually be integrated in GraphIO.jl https://github.com/JuliaGraphs/GraphIO.jl/pull/55
- MINDFulMakie https://github.com/UniStuttgart-IKR/MINDFulMakie.jl#main
  - awaits PR merge in public registry https://github.com/JuliaRegistries/General/pull/86457

You can `Pkg.update()` to update the environment to the latest versions.
With time, the `Manifest.toml` will not be needed, either because everything will be in the public registry or because of https://github.com/JuliaLang/Pkg.jl/issues/492.
