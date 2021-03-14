# PICAnalysisTools

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://SebastianM-C.github.io/PICAnalysisTools.jl/stable)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://SebastianM-C.github.io/PICAnalysisTools.jl/dev)
[![Build Status](https://github.com/SebastianM-C/PICAnalysisTools.jl/workflows/CI/badge.svg)](https://github.com/SebastianM-C/PICAnalysisTools.jl/actions)
[![Coverage](https://codecov.io/gh/SebastianM-C/PICAnalysisTools.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/SebastianM-C/PICAnalysisTools.jl)

This package provides useful analysis tools for PIC simulations.
## Installation

In order to use this package you need to add the [ctp-fpub Julia registry](https://github.com/ctp-fpub/JuliaRegistry)
```
]registry add https://github.com:ctp-fpub/JuliaRegistry.git
```

After that, you can install the package with
```
]add PICAnalysisTools
```

## Quick start

```julia
using SDFResults
using PICAnalysisTools

dir = "epoch_simulation"
sim = read_simulation(dir)
file = sim[2]

Ex = file[:ex]
size(Ex)

Ex_approx = approximate_field(Ex)
size(Ex)
```
