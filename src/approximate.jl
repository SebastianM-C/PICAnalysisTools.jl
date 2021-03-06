approx_target_size(::ScalarVariable) = 10^6
approx_target_size(::ScalarField) = 160

function approximate_field(f::AbstractPICDataStructure, sz::Int=approx_target_size(f))
    if unit(eltype(f)) ≠ NoUnits
        @debug "Removing units"
        approximate_field(ustrip(f), sz)
    else
        largest_dim = maximum(size(f))
        factor = largest_dim ÷ sz
        factor == 0 && return f
        target_size = map(i->i÷factor, size(f))
        @debug "Resizing to size $target_size from $(size(f))"
        downsample(f, target_size...)
    end
end
