module PICAnalysisTools

export apply_analytic, analytic_slice,
    track_particles, initial_cube,
    downsample_approx,
    mean_quantity, phase_space_mean

using PICDataStructures
using PICDataStructures: approx_target_size, dropgriddims
using RecursiveArrayTools
using Unitful
using FileTrees
using StaticArrays
using NumericalIntegration
using Transducers, ThreadsX
using Statistics
using ProgressLogging

include("analytic.jl")
include("tracking.jl")
include("statistics.jl")

end
