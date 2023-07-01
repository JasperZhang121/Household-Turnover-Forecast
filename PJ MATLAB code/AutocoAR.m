%AR(1) Process
N = 1000; u = randn(1,N);
y = zeros(1,N); ph = 0.7;
y(1) = ph*u(1);
for n = 2:N
y(n) = ph*y(n-1) + u(n);
end
[cov_y,lags_y] = xcov(y,10,'coeff');
stem(lags_y,cov_y)


%% Auto-covariance
[c,lags]=xcov(x);
stem(lags,c);
%% Random Walk