function z = black_scholes(s, k, t, v, rf, div, cp)
    
d1 = (log(s/k)+(rf-div+0.5*v*v)*t)/(v*sqrt(t));
d2 = d1 - v*sqrt(t);
optprice = cp*s*exp(-div*t)*std_norm_cdf(cp*d1)-cp*k*exp(-rf*t)*std_norm_cdf(cp*d2);
z = optprice;