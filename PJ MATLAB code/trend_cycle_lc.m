function loglike = trend_cycle_lc(omega,y)
T = length(y);
t = (1:T)'; %% build a vector from 1 to T
X = [ones(T,1) t cos(omega*t) sin(omega*t)];
beta = (X'*X)\(X'*y);
err = y-X*beta;
sig2 = err'*err/T;
loglike = -(-T/2*log(2*pi*sig2) -.5*(err'*err)/sig2);