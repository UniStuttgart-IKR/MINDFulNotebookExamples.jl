# MINDFulNotebookExamples

This is a repository containing some notebook examples for [MINDFul.jl](https://github.com/UniStuttgart-IKR/MINDFul.jl)

See the github pages deployment of this repository:

https://unistuttgart-ikr.github.io/MINDFulNotebookExamples.jl/

`Manifest.toml` is checked in since some still unregistered/forked repositories are required:
- MINDFulCompanion
  - still unregisted 
- NestedGraphMakie https://github.com/UniStuttgart-IKR/NestedGraphMakie.jl#main
  - public registry PR at works
- NestedGraphsIO https://github.com/UniStuttgart-IKR/NestedGraphsIO.jl#main
  - depends on GraphIO
- GraphIO https://github.com/filchristou/GraphIO.jl#typedefreqmov
  - PR https://github.com/JuliaGraphs/GraphIO.jl/pull/51
  - adaptation will be probably happen with julia v1.9 release because of the package extension feature.
- MINDFulMakie https://github.com/UniStuttgart-IKR/MINDFulMakie.jl#main
  - depends on GraphMakie
- GraphMakie https://github.com/filchristou/GraphMakie.jl#defdictattrs
  - PR https://github.com/MakieOrg/GraphMakie.jl/pull/89

Please do `Pkg.update()` to update the environment to the latest versions.
With time, the `Manifest.toml` will not be needed.
