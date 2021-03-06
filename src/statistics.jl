function mean_quantity(f, sim)
    tree = maketree(sim.dir => sim.files)

    quantity = FileTrees.load(tree, lazy=true) do file
        println("Loading $(path(file)) on thread $(Threads.threadid())")
        f(file.value)
    end
    exec(mapvalues(mean, quantity))
end
