%% input: x = [phi1, phi2,phi3,mu, psi];
%% input: y = data; y0 = lags;
function ell = loglike_ARMA31(x,y0,y)
phi = zeros(4,1);
phi(1) = x(1); phi(2) = x(2);
phi(3) = x(3);phi(4)=x(4); psi = x(5); %phi(4) is mu
N = length(y); m = length(y0);
A = speye(N); B = sparse(2:N,1:N-1,ones(1,N-1),N,N);
Gam = A + B*psi; Gam2 = Gam*Gam';
X = [[y0(m);y(1:N-1)] [y0(m-1:end);y(1:N-2)] [y0(m-2:end);y(1:N-3)] ones(N,1)];
ell = -(y-X*phi)'*(Gam2\(y-X*phi));
ell = - ell;