using SharedArrays

function parallel_pi(N::Int, ncores::Int)
    """
    Compute pi in parallel, over ncores cores, with a Monte Carlo simulation throwing N total darts
    """
 
# @distributed macro is used instead of @parallel macro

    ppi = SharedArray{Float64}(ncores)

    # compute sum of pi's estimated among all cores in parallel
    @sync @distributed for i=1:ncores
       ppi[i] = compute_pi(div(N,ncores))
    end
    
    sum_of_pis = 0.0
    sum_of_pi_sqs = 0.0
    for i=1:ncores
       sum_of_pis += ppi[i]
       sum_of_pi_sqs += ppi[i]*ppi[i]
    end
    
    pi_avg = sum_of_pis / ncores
    pi_sq_avg = sum_of_pi_sqs / ncores
    std = sqrt((pi_sq_avg - pi_avg*pi_avg) / ncores)

    return pi_avg, std  # average value
end