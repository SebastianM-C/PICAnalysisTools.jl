function initial_cube(sim, l=100u"nm"; species="electron")
    file = sim[1]
    r = file["grid/$species"]

    findall(rᵢ->rᵢ[1] ∈ zero(l)..l &&
            rᵢ[2] ∈ -l/2..l/2 &&
            rᵢ[3] ∈ -l/2..l/2, r)
end

function indexof(apparitions, haystack, n)
    found = zeros(Int, n)
    k = 1
    @inbounds for i in haystack
        if apparitions[i]
            found[k] = i
            k += 1
        end
    end

    return found
end

"""
    track_particles(sim, idxs; species="electron")

Track the particles with the initial index `idx` and species given
by the `species` argument in the simulation `sim`.
"""
function track_particles(sim, idxs; species="electron")
    n_total = get_npart(sim[1], species)
    n_searched = length(idxs)
    apparitions = falses(n_total)
    apparitions[idxs] .= true

    map(eachindex(sim.files)) do i
        file = sim[i]
        @time ids, r = file["id/$species", "grid/$species"]
        @debug "Loaded $(file.name)"
        ids = Int.(ids.data)
        if issorted(ids) && length(ids) == length(idxs)
            box_ids = ids
        else
            @time box_ids = indexof(apparitions, ids, n_searched)
        end
        filter!(!iszero, box_ids)

        @debug "Done with $i"
        SVector{3}.(r[1][box_ids], r[2][box_ids], r[3][box_ids])
    end
end
