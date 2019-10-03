using Distributed

ncores = 24
addprocs(ncores) # nCPUs need to be set before parallel macros appear

include("src\\compute_pi.jl")
include("src\\parallel_pi.jl")

println("number of threads = ",Threads.nthreads())

@time ppi, uncert = parallel_pi(100000000000, ncores)

println(pi," = ",Float64(pi),", ppi = ",ppi," +/- ",uncert,", diff = ",abs(pi-ppi))

