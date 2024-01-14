# MINDFulNotebookExamples

This is a repository containing some notebook examples for [MINDFul.jl](https://github.com/UniStuttgart-IKR/MINDFul.jl)

See the github pages deployment of this repository:

https://unistuttgart-ikr.github.io/MINDFulNotebookExamples.jl/

`Manifest.toml` is checked in since some still unregistered repositories are required:
- MINDFulCompanion
  - still unregisted 
- NestedGraphsIO https://github.com/UniStuttgart-IKR/NestedGraphsIO.jl#main
  - will eventually be integrated in GraphIO.jl https://github.com/JuliaGraphs/GraphIO.jl/pull/55

You can `Pkg.instantiate()` to replicate the environment to a guaranteed working version.
With time, the `Manifest.toml` will not be needed, either because everything will be in the public registry or because of https://github.com/JuliaLang/Pkg.jl/issues/492.

To run the notebooks
- clone this repository and retrieve the environemnt
- execute `Pkg.instantiate()` to replicate the environment
- start Pluto.jl from your general environment
- open the desired notebook

## JuliaCon 2024 (proposal)
The work on the `plutodash.jl` notebook is relevant to an applied JuliaCon2024 talk.
Refinements will happen in the following months and prior to the conference.
