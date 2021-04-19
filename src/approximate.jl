function approx_target_size(::Type{T}) where T
    approx_target_size(domain_discretization(T), scalarness(T))
end
approx_target_size(::ParticleGrid, ::ScalarQuantity) = 7*10^5
approx_target_size(::LatticeGrid{2}, ::ScalarQuantity) = 160
approx_target_size(::LatticeGrid{3}, ::ScalarQuantity) = 120
approx_target_size(::LatticeGrid{2}, ::VectorQuantity) = 25
approx_target_size(::LatticeGrid{3}, ::VectorQuantity) = 15

"""
    downsample_approx(f, sz::Int=approx_target_size(f))

Approximate the given input `f` using `downsample` such that no dimension exceeds `sz`.
"""
function downsample_approx(f::T, sz::Int=approx_target_size(T)) where T
    largest_dim = maximum(size(f))
    factor = largest_dim ÷ sz
    factor == 0 && return f
    target_size = map(i->i÷factor, size(f))
    @debug "Resizing to size $target_size from $(size(f))"
    downsample(f, target_size...)
end
