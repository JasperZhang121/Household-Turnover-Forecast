%% input: x = [phi1,mu, psi];
%% input: y = data; y0 = lags;
function ell = loglike_ARMA11(x,y0,y)
phi = zeros(2,1);
phi(1) = x(1); phi(2) = x(2);
psi = x(3); %phi(2) is mu
N = length(y); m = length(y0);
A = speye(N); B = sparse(2:N,1:N-1,ones(1,N-1),N,N);
Gam = A + B*psi; Gam2 = Gam*Gam';
X = [[y0(m);y(1:N-1)] ones(N,1)];
ell = -(y-X*phi)'*(Gam2\(y-X*phi));
ell = - ell;