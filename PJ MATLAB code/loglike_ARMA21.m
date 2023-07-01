%% input: x = [phi1, phi2, mu, psi];
%% input: y = data; y0 = lags;
function ell = loglike_ARMA21(x,y0,y)
phi = zeros(3,1);
phi(1) = x(1); phi(2) = x(2);
phi(3) = x(3); psi = x(4); %phi(3) is mu
N = length(y); m = length(y0);
A = speye(N); B = sparse(2:N,1:N-1,ones(1,N-1),N,N);
Gam = A + B*psi; Gam2 = Gam*Gam';
X = [[y0(m);y(1:N-1)] [y0(m-1:end);y(1:N-2)] ones(N,1)];
ell = -(y-X*phi)'*(Gam2\(y-X*phi));
ell = - ell;