module PICAnalysisTools

export track_particles, initial_cube,
    downsample_approx,
    mean_quantity, phase_space_mean

using PICDataStructures
using PICDataStructures: dir_to_idx
using RecursiveArrayTools
using Unitful
using FileTrees
using StaticArrays
using NumericalIntegration
using Transducers, ThreadsX
using Statistics
using ProgressLogging

include("tracking.jl")
include("approximate.jl")
include("statistics.jl")

end
