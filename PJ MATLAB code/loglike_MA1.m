%% Function loglikelhood MA(1) input: x = [sig, theta]; y = data
function ell = loglike_MA1(x, y)
sig = x(1);
theta = x(2);
T = length(y);
A = speye(T);
B = sparse(2:T, 1:T-1, ones(1,T-1),T,T);
Gam = A + B*theta;
Gam2 = Gam*Gam';
ell = -T/2*log(2*pi*sig) - .5*log(det(Gam2)) - .5/sig *y'*(Gam2\y);
ell = - ell;


