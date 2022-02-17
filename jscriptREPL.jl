using Distributed

ncores = 8
addprocs(ncores)

#import Pkg
#Pkg.add("DecisionTree")
#import DecisionTree
#@everywhere using DecisionTree  #push code to all clients

include("src\\compute_pi.jl")
include("src\\parallel_pi.jl")

#define julia_p as "julia -p 1" that is "-p 1" as argument to the interpreter "julia"
#the above seems to be necessary to accept the parallel macros

@time ppi, uncert = parallel_pi(10000000000, ncores)

println(pi," = ",pi+0.0,", ppi = ",ppi," +/- ",uncert)

