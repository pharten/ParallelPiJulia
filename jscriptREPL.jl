using Distributed

ncores = 16
addprocs(ncores)

include("src\\compute_pi.jl")
include("src\\parallel_pi.jl")

#define julia_p as "julia -p 1" that is "-p 1" as argument to the interpreter "julia"
#the above seems to be necessary to accept the parallel macros

@time ppi, uncert = parallel_pi(2^40, ncores)

println(pi," = ",pi+0.0,", ppi = ",ppi," +/- ",uncert,", deltaPi = ",abs(pi-ppi))

