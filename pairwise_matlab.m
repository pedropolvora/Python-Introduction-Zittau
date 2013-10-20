function z = pairwise_matlab(X)
M = size(X,1);
N = size(X,2);
D = ones(M,M);
for i=[1:M]
    for j=[1:M]
        d = 0.0;
        for k=[1:N]
            tmp = X(i,k)-X(j,k);
            d = d + tmp*tmp;
        D(i,j) = sqrt(d);
        end
    end
end
z = D;

