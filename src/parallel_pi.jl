using SharedArrays

function parallel_pi(N::Int, ncores::Int)
    """
    Compute pi in parallel, over ncores cores, with a Monte Carlo simulation throwing N total darts
    """
 
# @distributed macro is used instead of @parallel macro

    ppi = SharedArray{Float64}(ncores)
    m = div(N,ncores)

    # compute sum of pi's estimated among all cores in parallel
    @sync @distributed for i=1:ncores
       println(" m = ",m)
       ppi[i] = compute_pi(m)
    end
    
    sum_of_pis = 0.0
    sum_of_pi_sqs = 0.0
    for i=1:ncores
       sum_of_pis += ppi[i]
       sum_of_pi_sqs += ppi[i]*ppi[i]
    end
    
    if (ncores <= 1)
       pi_avg = sum_of_pis / ncores
       uncert = 0
    else
       pi_avg = sum_of_pis / ncores
       pi_sq_avg = sum_of_pi_sqs / ncores
       stdsq = pi_sq_avg - pi_avg*pi_avg
       uncert = sqrt(stdsq/ncores)
    end

    return pi_avg, uncert  # average value
end