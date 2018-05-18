include("src\\compute_pi.jl")
include("src\\parallel_pi.jl")

@time parallel_pi(1600000000, 2)