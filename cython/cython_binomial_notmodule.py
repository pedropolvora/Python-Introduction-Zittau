'''
Call option valuation using the theoretical binomial model.
Inspired from Wilmott, Paul, "Paul Wilmott Introduces Quantitative Finance", 2nd ed., John Wiley & Sons, 2007
'''
from __future__ import division
from numpy import array, zeros, exp, sqrt, linspace, zeros_like

import cython_binomial 
 
    
if __name__ == '__main__':
    import time   
    from pylab import plot, show, xlabel, title
 
    v_rates = linspace(.01, 0.2, 1000)    
    option_prices = zeros_like(v_rates)
    asset = 100
    strike = 100
    interest_rate = .05
    expiry = 4
    steps = 12
 
    t = time.time()
    for i, volatility in enumerate(v_rates):
        option_prices[i] = cython_binomial.binomial_price(asset, volatility, interest_rate, strike, expiry, steps)    
    print 'Execution time:', time.time() - t
 
    plot(v_rates, option_prices)
    xlabel('Volatility')
    title('Option Prices')
    print 'S0 -> %.2f'%asset
    print 'K -> %.2f'%strike
    print 'r -> %.2f'%interest_rate
    print 'T -> %.2f'%expiry
    print 'number of steps -> %.2f'%steps
    show()
    
