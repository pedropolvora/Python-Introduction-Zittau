import numpy
cimport cython
cimport numpy as np
 
cdef extern from "math.h":
    double sqrt(double x)
    double exp(double x)
 
cdef inline double payoff(double S, double K):
    return (S-K) if S > K else 0.
 
@cython.boundscheck(False)
@cython.wraparound(False)
def binomial_price(double asset, 
                    double volatility, 
                    double interest_rate, 
                    double strike, 
                    unsigned int expiry, 
                    unsigned int steps):
    """
    Compute the option price for the given arguments using a binomial model
    """
     
    cdef Py_ssize_t bsteps = steps + 1
    cdef np.ndarray[double, ndim=1] s = numpy.zeros(dtype="d", shape=(bsteps)) # asset array
    cdef np.ndarray[double, ndim=1] v = numpy.zeros(dtype="d", shape=(bsteps)) # option array
     
    cdef double time_step = 1.0 * expiry / bsteps
    cdef double discount_factor = exp(-interest_rate * time_step)
    cdef double temp1 = exp((interest_rate + volatility * volatility) * time_step)
    cdef double temp2 = 0.5 * (discount_factor + temp1)
    cdef double u = temp2 + sqrt(temp2 * temp2 -1)    
    cdef double d = 1./u    
    cdef double p = (exp(interest_rate * time_step) - d ) / (u-d)       
     
    s[0] = asset   
    cdef Py_ssize_t i, j, n
    for i in range(1, bsteps):       
        for j in range(i, 0, -1):             
            s[j] = u * s[j-1]
        s[0] = d * s[0]
     
    for j in range(bsteps):
        v[j] = payoff(s[j], strike)   
     
    for n in range(steps):
        for j in range(steps):
            v[j] = ((p * v[j+1]) + ((1-p) * v[j])) * discount_factor    
 
    return v[0]
