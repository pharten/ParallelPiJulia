include("src\\compute_pi.jl")
include("src\\parallel_pi.jl")

#define julia_p as "julia -p 1" that is "-p 1" as argument to the interpreter "julia"
#the above seems to be necessary to accept the parallel macros

#using Distributed
#addprocs(3)
#the above two lines seems to be implemented by the @distributed macro

@time ppi, std = parallel_pi(10000000000, 6)

println(ppi," +/- ",std)
