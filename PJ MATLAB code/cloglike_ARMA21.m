%% negative of the con log−lilkelihood for ARMA(2,1)
%% input: x = [psi];
%% input: y = data; y0 = lags;
function ell = cloglike_ARMA21(x,y0,y)
psi = x(1);
N = length(y); m = length(y0);
A = speye(N); B = sparse(2:N,1:N-1,ones(1,N-1),N,N);
Gam = A + B*psi;
Gam2 = Gam*Gam';
X = [[y0(m);y(1:N-1)] [y0(m-1:end);y(1:N-2)] ones(N,1)];
phi = (X'*Gam2\X)\(X'*(Gam2\y));
ell = -(y- X*phi)'*(Gam2\(y-X*phi));
%transformed ell removing sigma
ell = - ell;