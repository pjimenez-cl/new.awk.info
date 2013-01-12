# pi.awk: approximate pi by integrating f(x) = 4/(1+x^2)
# n = number of intervals to calculate 
#
# e.g.: mpiexec -n 4 mpawk -v n=10000 -f pi.awk 

BEGIN {
    h = 1/n
    for(i = RANK+1 ; i <= n ; i += SIZE) {
        x = h * (i - 0.5)
        sum +=  4 / (1 + x^2)
    }
    pi = reduce(sum(h * sum))
    if(!RANK) printf("n=%d, pi is %1.20f\n",n,pi)
}
