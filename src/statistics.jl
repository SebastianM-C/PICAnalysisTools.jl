function mean_quantity(f, sim)
    tree = maketree(sim.dir => sim.files)

    quantity = FileTrees.load(tree, lazy=true) do file
        println("Loading $(path(file)) on thread $(Threads.threadid())")
        f(file.value)
    end
    exec(mapvalues(mean, quantity))
end

function phase_space_mean(sim, dir::Symbol; species="electron", rcond=(i,x)->true)
    p1 = sim[1]["p$dir/"*species]
    r1 = getdomain(p1)[dir_to_idx(dir)]
    r_mean = eltype(r1)[]
    p_mean = eltype(p1)[]
    rp_mean = @progress for (idx, file) in enumerate(sim)
        # println("Loading $(file.name)")
        p = file["p$dir/"*species]
        r = getdomain(p)[dir_to_idx(dir)]

        # it't not important to optimize the mean computation
        # It takes 0.07s serial for 82 milion elements and 0.017s parallel
        idx = map(i->rcond(idx, r[i]), eachindex(r))
        @debug "Got $(length(idx)) items that satisfy the condition"
        push!(p_mean, mean(view(p, idx)))
        push!(r_mean, mean(view(r, idx)))
    end

    return r_mean, p_mean
end
