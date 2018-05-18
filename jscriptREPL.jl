include("src\\compute_pi.jl")
include("src\\parallel_pi.jl")

@time parallel_pi(10000000, 2)
#@time compute_pi(10000000)