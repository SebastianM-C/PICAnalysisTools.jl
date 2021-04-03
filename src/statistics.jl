function mean_quantity(f, sim)
    tree = maketree(sim.dir => sim.files)

    quantity = FileTrees.load(tree, lazy=true) do file
        println("Loading $(path(file)) on thread $(Threads.threadid())")
        f(file.value)
    end
    exec(mapvalues(mean, quantity))
end

function phase_space_mean(sim, dir::Symbol; species="electron", cond=x->true)
    rp_mean = ThreadsX.map(sim.files) do file
        println("Loading $(file.name)")
        p = file["p$dir/"*species]
        r = getdomain(p)[dir_to_idx(dir)]
        zp = zero(eltype(p))
        zr = zero(eltype(r))

        p_mean = (p ./ length(p)) |>
            Filter(cond) |>
            foldxt(+, simd=true, init=zp)

        r_mean = (r ./ length(r)) |>
            Filter(cond) |>
            foldxt(+, simd=true, init=zr)

        return r_mean, p_mean
    end
    @time r = [rp[1] for rp in rp_mean]
    @time p = [rp[2] for rp in rp_mean]

    return r, p
end
