function apply_analytic(f, grid, t, laser, x₀, y₀, z₀)
    mapgrid(grid) do (x,y,z)
        r = SVector{3}(x-x₀, y-y₀, z-z₀)

        f(r, t, laser)
    end
end

function apply_analytic(f, grid, t, laser;
    f_unit,
    downsample_grid=true,
    x₀=zero(recursive_bottom_eltype(grid)),
    y₀=zero(recursive_bottom_eltype(grid)),
    z₀=zero(recursive_bottom_eltype(grid)))

    r₀ = SVector{3}(x₀, y₀, z₀)
    # TODO: Can this be done more elegantly?
    ret_type = Base._return_type(f, (typeof(r₀),typeof(t),typeof(laser)))
    @debug "Return type of supplied function: $ret_type"
    if ret_type isa Number
        _scalarness = ScalarQuantity()
    else
        _scalarness = VectorQuantity()
    end
    sz = approx_target_size(domain_discretization(typeof(grid)), _scalarness)
    grid = downsample_grid ? downsample(grid, approx_size=sz) : grid
    data = apply_analytic(f, grid, t, laser, x₀, y₀, z₀)

    u_data = map(x->uconvert.(f_unit, x), data)
    if _scalarness === ScalarQuantity()
        ScalarField(u_data, grid)
    else
        # TODO get component names form the grid
        VectorField(u_data, grid, (:x, :y, :z))
    end
end

function analytic_slice(f, grid, t, laser, dir, slice_location;
    downsample_grid=false,
    f_unit,
    x₀=zero(recursive_bottom_eltype(grid)),
    y₀=zero(recursive_bottom_eltype(grid)),
    z₀=zero(recursive_bottom_eltype(grid))
    )

    grid_slice = selectdim(grid, dir, slice_location)
    slice = apply_analytic(f, grid_slice, t, laser;
        downsample_grid, f_unit, x₀, y₀, z₀)
    result = dropgriddims(dropdims(slice, dims=dir), dims=dir)
    downsample_grid ? downsample(result) : result
end
