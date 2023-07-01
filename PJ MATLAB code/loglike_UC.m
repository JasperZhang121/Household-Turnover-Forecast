function ell = loglike_UC(sig,omega,y,Vtau)
T = length(y);
%% compute the MLE for tau given sig and omega
H = speye(T) - sparse(2:T,1:(T-1),ones(1,T-1),T,T);
invOmega = sparse(1:T,1:T,[1/Vtau 1/omega*ones(1,T-1)]);
HinvOmegaH = H'*invOmega*H;
K = speye(T)/sig + HinvOmegaH;
tauhat = K\(y/sig);
err = (y-tauhat)'*(y-tauhat)/sig + tauhat'*HinvOmegaH*tauhat;
ell = -T/2*log(sig) - (T-1)/2*log(omega) - .5*err;
ell = -ell;
