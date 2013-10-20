function z = matlab_benchmarking()
disp('BS');tic;
for i=[0:100000]
    data = black_scholes(100.0, 100.0, 1.0, 0.3, 0.03, 0.0, -1);
end
z = toc/100000;
disp('Done');
