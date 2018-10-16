function parallel_pi(N::Int, ncores::Int)
    """
    Compute pi in parallel, over ncores cores, with a Monte Carlo simulation throwing N total darts
    """
 
# @distributed macro is used instead of @parallel macro

    # compute sum of pi's estimated among all cores in parallel
    sum_of_pis = @distributed (+) for i=1:ncores
       compute_pi(div(N,ncores))
    end

    return sum_of_pis / ncores  # average value
end
