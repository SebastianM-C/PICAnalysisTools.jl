approx_target_size(::Type{T}) where T = approx_target_size(domain_discretization(T))
approx_target_size(::ParticleGrid) = 7*10^5
approx_target_size(::LatticeGrid) = 160

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
